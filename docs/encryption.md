# Using AWS KMS to encrypt secrets in the platform.

If your security policies prevent using secrets directly in Terraform, you can use AWS KMS to encrypt configuration data. You will have to jump through additional hoops to deploy the platform.

## Multi-Stage Deployment

### Step 1: Stand up the IAM role

Your terraform configs should look like this:

```
provider "aws" {
  region  = var.region
  profile = var.profile
}

data "aws_region" "current" {}

module "servicesiam" {
  source = "github.com/graymeta/terraform-aws-platform//modules/servicesiam?ref=v0.2.0"

  platform_instance_id = "${var.platform_instance_id}"
}
```

You can comment everything else out of the file.

Peform a `terraform plan` and `terraform apply`


### Step 2: Create a KMS Customer Master Key

Log into the AWS KMS console (IAM->Encryption keys). Create a new KMS CMK or use an existing CMK. The key must exist in the same region into which you are deploying the platform. When provisioning the key or using an existinng key, add the IAM role `GrayMetaPlatform-{platform_instance_id}-Services-AssumeRole2` (where `{platform_instance_id}` is replaced by what you chose in the `locals` block) to the list of users that can use the key to encrypt and decrypt data. Record the ARN of the CMK.

### Step 3: Generate the encrypted configuration blob

Contact GrayMeta to get a copy of the `gmcrypt` utility. Ensure you have credentials set up in your `~/.aws/credentials` file that are allowed to use the KMS CMK. If you have credentials but they are not the `default` profile, set the `AWS_PROFILE` environment variable to the profile's name that contains the credentials.

Write out the configs you wish to encrypt into a single text file. The format is `key=value` pairs, one per line. Example:

```
# cat data.txt
key1=value1
key2=value2
```

Encrypt the file:

```
# gmcrypt -key-arn <arn of key> -region <region you are deploying into> data.txt
```

A base64 encoded string will be output. This string becomes the `encrypted_config_blob` variable in the next step

### Step 4: Add the rest of the configs to the terraform module

Add in the terraform.tfvars:

```
# Using AWS KMS to encrypt secrets in the platform.  Leave blank if not using this.
# https://github.com/graymeta/terraform12-aws-platform/blob/master/docs/encryption.md
encrypted_config_blob = "base64 encoded string from gmcrypt"
```

Then run a `terraform plan` and a `terraform apply`


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