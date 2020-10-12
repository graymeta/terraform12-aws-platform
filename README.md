# Deploying GrayMeta Platform with Terraform 12

![Graymeta Terraform Enterprise](images/Graymeta_Terraform_Enterprise.png)

* `version` - Current version is v1.0.0
* Only Terraform 12 is supported at this time.

## Basic Installation steps:

* Contact Graymeta support@graymeta.com to get permissions and needed licenses.

**Navigate to the following docs:**
* [Create s3 buckets](./docs/buckets.md) - This step must be completed prior to deploying the Curio platform.
* [Deploy platform](./docs/platform.md) - Following the steps in this doc will deploy a "base" Curio system, without encryption. Please see optional feature documentation for instructions on enabling and configuring.

### Optional Features
[Encryption](./docs/encryption.md) - If your security policies prevent using secrets directly in Terraform, you can use AWS KMS to encrypt configuration data.

[Oauth Storage](./docs/oauth-storage.md) - Most Oauth based cloud storage providers supported (see documentation for supported providers).

[S3 Notifications](./docs/s3notifications-setup.md) - Configure the GrayMeta Platform to analyze files triggered by S3 notifications.

[SAML](./docs/saml.md) - SP initiated SAML logins supported (see documentation for supported identity providers).

### Monitoring
[Monitoring](./docs/monitoring.md) Health and "pre-flight" checks to make sure everything is running and configured correctly.
