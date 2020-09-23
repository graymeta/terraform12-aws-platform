# OAuth based storage provider configuration

The below instructions will allow you to deploy Curio with additional OAuth based storage providers.  Once these configurations have been added to your [terraform.tfvars] (terraform.tfvars) file and deployed, the new provider will be available from the Connect section in Curio.  Please note that in order to incorporate these storage providers, you will need to create your own apps and supply the required credentials.  These instructions assume you will be adding a single provider, but if adding multiple storage providers, you may skip deploying your Terraform environment until all provider info has been input.

## Box.com

* Navigate to https://app.box.com/developers/services.
* Click "Create new App".
* Select "Custom App" then select "Next".
* Select "Standard OAuth 2.0 (User Authentication)" and select "Next".
* Give your app a unique name, then select "Create App".
* Select "View your app".
* Under "Oauth 2.0 Credentials" record the Client ID and Client Secret as the `box_com_client_id` and `box_com_secret_key` input Terraform variables to your [terraform.tfvars] (terraform.tfvars) file.
* In the "OAuth 2.0 Redirect URI" section of your box app, set the Redirect URI to `https://{dns_name}:8443/connect` (where `{dns_name}` is the domain name you will be hosting the platform on).
* Select "Save Changes".
* Deploy your Terraform environment.


## Dropbox

* Navigate to https://www.dropbox.com/developers/apps.
* Select "Create app".
  * Under "Choose an API" select "Dropbox Legacy API".
  * Under "Choose the type of access you need" select "Full Dropbox".
  * Give your app a unique name.
* Record the "App key" and "Application secret" as the `dropbox_app_key` and `dropbox_app_secret` input Terraform variables to your [terraform.tfvars] (terraform.tfvars) file.
* In the "OAuth 2" section of your dropbox app console, under "Redirect URIs", add `https://{dns_name}:8443/connect` (where `{dns_name}` is the domain name you will be hosting the platform on) as a Redirect URI.
* In the "Status" section, click "Apply For Production" to enable all users (not just your account) to use the Dropbox integration.
* Deploy your Terraform environment.

## Dropbox Teams

* Navigate to https://www.dropbox.com/developers/apps.
* Select "Create app".
  * Under "Choose an API" select "Dropbox Business API".
  * Under "Choose the type of access you need" select "Team member file access".
  * Give your app a unique name.
* Record the "App key" and "Application secret" as the `dropbox_teams_app_key` and `dropbox_teams_app_secret` input Terraform variables to your [terraform.tfvars] (terraform.tfvars) file.
* In the "OAuth 2" section of your dropbox app console, under "Redirect URIs", add `https://{dns_name}:8443/connect` (where `{dns_name}` is the domain name you will be hosting the platform on) as a Redirect URI.
* Under the "Status" section, "Apply For Production" to enable all users (not just your account) to use the Dropbox integration.
* Deploy your Terraform environment.

## Onedrive

* Navigate to https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationsListBlade.
* Select "New registration".
  * Give your app a unique name.
  * Under "Supported Account Types" select "Accounts in any organizational directory".
  * Under "Redirect URI" enter in your base URL/connect (Ex: `https://{dns_name}:8443/connect`).
* Record the "Application ID" from the app Overview section and input as `onedrive_client_id` to your [terraform.tfvars] (terraform.tfvars) file.
* Create client secret under "Certificates & Secrets" and input the Value as Terraform variable `onedrive_client_secret` to your [terraform.tfvars] (terraform.tfvars) file.
* In the "API permissions" section of the app console, add the following Graph API permissions as Delegated permissions `User.Read`, `Files.Read`, `offline_access`.
* Deploy your Terraform environment.

## Sharepoint

* Navigate to https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationsListBlade.
* Select "New registration".
  * Give your app a unique name.
  * Under "Supported Account Types" select "Accounts in any organizational directory".
  * Under "Redirect URI" enter in your base URL/connect (Ex: `https://{dns_name}:8443/connect`).
* Record the "Application ID" from the app Overview section and input as `sharepoint_client_id` to your [terraform.tfvars] (terraform.tfvars) file.
* Create client secret under "Certificates & Secrets" and input the Value as Terraform variable `sharepoint_client_secret` to your [terraform.tfvars] (terraform.tfvars) file.
* In the "API permissions" section of the app console, add the following Graph API permissions as Delegated permissions `User.Read`, `Files.Read`, `offline_access`, `Group.Read.All`.
* Deploy your Terraform environment.
