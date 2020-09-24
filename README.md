# Deploying GrayMeta Platform with Terraform 12

![Graymeta Terraform Enterprise](images/Graymeta_Terraform_Enterprise.png)

* `version` - Current version is v1.0.0
* Only Terraform 12 is supported at this time.

## Basic Installation steps:
* Contact Graymeta support@graymeta.com to get permissions and needed licenses.
* Set variables used in in all of the module installs:
  * `platform_instance_id` - Pick a platform instance id for this deployment of the GrayMeta platform. A short, descriptive name like production, labs, test, etc. that can be used to uniquely identify this deployment of the GrayMeta Platform within your environment.
  * `profile` - AWS profile to use on deployment
  * `region` - Pick which AWS region you want to deploy into from this list: [ us-east-1, us-east-2, us-west-2, ap-southeast-2, eu-west-1 ]

**Navigate to the following docs:**
* [Create s3 buckets](./docs/buckets.md) - This step must be completed prior to deploying the Curio platform.
* [Deploy platform](./docs/platform.md) - Following the steps in this doc will deploy a "base" Curio system. Please see optional feature documentation for instructions on enabling and configuring.

### Optional Features
[Encryption](./docs/encryption.md) -If your security policies prevent using secrets directly in Terraform, you can use AWS KMS to encrypt configuration data.

[Oauth Storage](./docs/oauth-storage.md) - Most Oauth based cloud storage providers supported (see documentation for supported providers).

[S3 Notifications](./docs/s3-notifications-setup.md) - Configure the GrayMeta Platform to analyze files triggered by S3 notifications.

[SAML](./docs/saml.md) - SP initiated SAML logins supported (see documentation for supported identity providers).

### Monitoring
[Monitoring](./docs/monitoring.md) Health and "pre-flight" checks to make sure everything is running and configured correctly.
