# profile - AWS api profile to use on deployment
profile = "default"

# region - Pick which AWS region you want to deploy into from the list: 
# us-east-1, us-east-2, us-west-2, ap-southeast-2, eu-west-1
region = "us-east-1"

# platform_instance_id - Pick a platform instance id for this deployment of the GrayMeta platform. 
# A short, descriptive name like production, labs, test, etc. that can be used to uniquely identify 
# this deployment of the GrayMeta Platform within your environment.
platform_instance_id = "test"

# key_name - The default ssh key name to access the instances.
key_name = "somekey"

# Subnet id to deploy in
subnet_id = ""