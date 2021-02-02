# Using AWS KMS to encrypt secrets in the platform.

If your security policies prevent using secrets directly in Terraform, you can use AWS KMS to encrypt configuration data. You will have to complete some additional steps to deploy the platform.

Note: Encrypting RDS usernames is not supported at this time.

Prerequisites: You should have all of the variables set in your `terraform.tfvars` file.

Before you begin, please take the time to read through these steps carefully. Skipping steps or doing them incorrectly will likely result in having to start the process over, from scratch.

## Multi-Stage Deployment

### Step 1: Stand up the IAM role

Your terraform `mainf.tf` configs should look like this:

```
provider "aws" {
  region  = var.region
  profile = var.profile
}

data "aws_region" "current" {}

module "services_iam_role" {
  # source = "./modules/iam/services_role"
  source = "github.com/graymeta/terraform12-aws-platform//modules/iam/services_role?ref={tag}"

  platform_instance_id = var.platform_instance_id
}
```

Comment out everything else in the `main.tf` file.

Perform a `terraform init`, `terraform plan` and `terraform apply -var-file=terraform.tfvars -var-file={sizing_foo}.tfvars`.

### Step 2: Create a KMS Customer Master Key

Log into the AWS KMS console (IAM->Encryption keys). Create a new KMS CMK or use an existing CMK. The key must exist in the same region into which you are deploying the platform. When provisioning the key or using an existing key, add the IAM role `GrayMetaPlatform-{platform_instance_id}-Services-AssumeRole2` (where `{platform_instance_id}` is replaced by what you chose in the `locals` block) to the list of users that can use the key to encrypt and decrypt data. Record the ARN of the CMK.

### Step 3: Generate the encrypted configuration blob

Contact GrayMeta to get a copy of the `gmcrypt` utility. Ensure you have credentials set up in your `~/.aws/credentials` file that are allowed to use the KMS CMK. If you have credentials but they are not the `default` profile, set the `AWS_PROFILE` environment variable to the profile's name that contains the credentials.

Write out the configs you wish to encrypt into a single text file. The format is `key=value` pairs, one per line.

Valid example:
```
# cat data.txt
key1=value1
key2=value2
```
Invalid example:
```
# cat data.txt
key1 = "value1"
key2 = "value2"
```

Encrypt the file:

```
# gmcrypt -key-arn <arn of key> -region <region you are deploying into> data.txt
```

A base64 encoded string will be output. This string becomes the `encrypted_config_blob` variable in the next step.

### Step 4: Add the rest of the configs to the Terraform module.

Add in the `gmcrypt` output to the `encrypted_config_blob` in `terraform.tfvars`:

```
# Using AWS KMS to encrypt secrets in the platform.
# Leave blank if not using this.
# https://github.com/graymeta/terraform12-aws-platform/blob/master/docs/encryption.md
encrypted_config_blob = "base64 encoded string from gmcrypt"
```

NOTE: If you are encrypting `rds_password` you must use `omitpassword` as a temporary password, i.e. `rds_password = "omitpassword"`.
Curio will ignore this password and use the encrypted one your provided. You cannot set this variable to a blank value `""`, or use a different temporary password. Ignoring this step will cause Curio to be unable to connect to RDS and require you to start over.

AWS RDS password constraints:
>  At least 8 printable ASCII characters. Can't contain any of the following: / (slash), '(single quote), "(double quote) and @ (at sign).

There are some variables keys that map to a different key, which must be used for encryption. They are as follows:

| terraform.tfvars key name | encrypted key name        |
|---------------------------|---------------------------|
| client_secret_fe          | gm_front_end_client_secret|
| client_secret_internal    | gm_internal_client_secret |
| encryption_key            | gm_encryption_key         |
| jwt_key                   | gm_jwt_private_key        |
| logograb_key              | gm_logograb_api_key       |
| rds_password              | gm_db_password            |


Now, run a `terraform plan` and a `terraform apply -var-file=terraform.tfvars -var-file={sizing_foo}.tfvars`.


### Change RDS Master Password in AWS Console, and retrieve Services instance IDs.

In the AWS Console, navigate to RDS. Under Databases, select the DB identified as `gm-{platform_instance_id}-0`. Click `Modify` and change the master password to the unencrypted password in your text file. For example, if your text file has `gm_db_password=ILoveGrayMeta`, enter `ILoveGrayMeta` as the new master password in the console.

Click `Continue`.

Under `Scheduling of modifications` select `Immediately`. Then click `Modify DB Instance.

Navigate to EC2 and record the instance-ID of the service(s) instances, identified as `GrayMetaPlatform-{platform_instance_id}-Services`. One of these is your initial password to log in to the Curio UI.

Finally, select all of the `GrayMetaPlatform-{platform_instance_id}-Services` (you may or may not have more than one, depending on your deployment size). Click `Actions` > `Instance state` > `Terminate instance`.

The services instances will be terminated, and auto-scaling will spin up new instances bringing all of these steps in to sync.

You should now be able to log in to Curio with one of the instance-IDs. It is recommended you change this password after your initial log in.

---

# Migrating from RDS to encrypted.

* Manually create a snapshot as a backup.  The destroy should create a final backup.  This is just in case something goes wrong.
* Destroy the existing database
```
terraform destroy -target=module.platform.module.rds.aws_db_instance.default
```
* Create a new KMS key and add the following to the platform configuration.
```
module "platform" {
    source = "github.com/graymeta/terraform-aws-platform?ref=v0.2.0"
    ...
    db_storage_encrypted = true
    db_kms_key_id        = "arn:aws:kms:us-west-2:1111111111111:key/11111111-1111-11111-11111-111111111"
    ...
}
```
* Go into AWS console -> RDS -> Snapshots -> Look for a snapshot that has the name GrayMetaPlatform-<platform_instance_id>-final.  
* Select Copy on that snapshot and enable encryption on the copy.  Then wait for the copy to complete.
* Add the following to the platform configuration
```
  db_snapshot = "<copy snapshot name>"
```
* Then run a `terraform plan` and a `terraform apply`
* Then update db_snapshot to final
```
  db_snapshot = "final"
```
