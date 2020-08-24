# Deploying GrayMeta Platform with Terraform 12

![Graymeta Terraform Enterprise](images/Graymeta_Terraform_Enterprise.png)

* `version` - Current version is v0.0.1
* Terraform 12 is only supported at this time.



Installation steps
* Contact Graymeta support@graymeta.com to get permissions and needed licenses.
* Variables used in in all of the module installs.
  * `platform_instance_id` - Pick a platform instance id for this deployment of the GrayMeta platform. A short, descriptive name like production, labs, test, etc. that can be used to uniquely identify this deployment of the GrayMeta Platform within your environment.
  * `profile` - AWS profile to use on deployment
  * `region` - Pick which AWS region you want to deploy into from the list: [ us-east-1, us-east-2, us-west-2, ap-southeast-2, eu-west-1 ]

* [Create s3 buckets](./docs/buckets.md)
* [Deploy platform](./docs/platform.md)
