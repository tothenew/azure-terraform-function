# terraform-azure-function-app

[![Lint Status](https://github.com/tothenew/terraform-aws-template/workflows/Lint/badge.svg)](https://github.com/tothenew/terraform-aws-template/actions)
[![LICENSE](https://img.shields.io/github/license/tothenew/terraform-aws-template)](https://github.com/tothenew/terraform-aws-template/blob/master/LICENSE)

This Terraform configuration deploys Azure Function Apps, including both Linux and Windows-based Function Apps . It also provisions additional resources such as a Resource Group , Azure App Service Plan, Application Insights, Storage Container.

The following resources will be created:
 - Resource Group
 - Azure App Service Plan
 - Azure Linux-based Function Apps
 - Azure Windows-based Function Apps

## Requirements

Before you begin, ensure you have the following requirements met:

1. Install Terraform (>= 1.3.0). You can download the latest version of Terraform from the official website: [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)

2. Azure CLI installed and configured with appropriate access rights. You can install the Azure CLI from [https://docs.microsoft.com/en-us/cli/azure/install-azure-cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)


## Providers

| Name | Version |
|------|---------|
| <a name="provider_Azure"></a> [azurerm](#provider\_azure) | >=3.0 |


## Resources

This Terraform configuration provisions the following Azure resources:
 
| Name                                    | Description                                                  | Type     |
|-----------------------------------------|--------------------------------------------------------------|----------|
|  `azurerm_service_plan`       | Azure App Service Plan                            |  `azurerm` |
| `azurerm_linux_function_app` | Linux-based Azure Function Apps - A serverless compute service that enables you to run code on-demand without having to explicitly provision or manage infrastructure.               |  `azurerm` |
| `azurerm_windows_function_app`| Windows-based Azure Function Apps - A serverless compute service that enables you to run code on-demand without having to explicitly provision or manage infrastructure.              |  `azurerm` |
 

### Inputs

#### Basic Configuration

| Name                            | Description                                     | Type      | Default          | Required |
|---------------------------------|-------------------------------------------------|-----------|------------------|----------|
| resource_group_name             | Name of the Azure Resource Group where the resources will be created. | string | "function-app-rg" | yes      |
| location                        | The Azure region where the resources will be deployed. E.g., 'East US', 'West Europe', etc. | string | "Central India" | yes |
| create_resource_group           | Whether to create a new Resource Group.         | bool      | false            | no       |
| create_storage_account          | Whether to create a new Storage Account.        | bool      | false            | no       |
| storage_name                    | Storage account name to use if not don't have an existing storage account. | string | null | no       |
| storage_account_access_key      | Storage account access key to use if not don't have an existing storage account. | string | null | no       |

#### Tags Configuration

| Name                            | Description                                     | Type      | Default          | Required |
|---------------------------------|-------------------------------------------------|-----------|------------------|----------|
| project_name_prefix             | Used in tags cluster and nodes.                 | string    | "dev"            | no       |
| default_tags                    | A map to add common tags to all the resources.  | map(string) | {"Scope" : "database", "CreatedBy" : "Terraform"} | no |
| common_tags                     | A map to add common tags to all the resources.  | map(string) | {"Project": "Azure_database", "Managed-By": "TTN"} | no |

#### Storage Account Configuration

| Name                            | Description                                     | Type      | Default          | Required |
|---------------------------------|-------------------------------------------------|-----------|------------------|----------|
| storage_account_name            | Storage account name if have an existing storage account. | string | "terraformteststacc01" | no |
| storage_account_resource_group_name | Storage account resource group name if have an existing storage account. | string | "function-app-rg" | no |

#### App Service Plan Configuration

| Name                            | Description                                     | Type      | Default          | Required |
|---------------------------------|-------------------------------------------------|-----------|------------------|----------|
| `resource_group_name`                | The name of the Azure Resource Group where the resources will be created | string        | `"function-app-rg"`                                      |
| `location`                           | The Azure region where the resources will be deployed                 | string        | `"Central India"`                              |
| service_plan_name               | Name of the Azure App Service Plan.             | string    | "app-service-plan" | no       |
| os_type                         | Operating system type for the App Service Plan. | string    | "Windows"        | no       |
| sku_name                        | SKU name for the App Service Plan.              | string    | "Y1"             | no       |

#### Function Apps Configuration


| Variable Name                        | Description                                                            | Type          | Default Value                                   |
|--------------------------------------|------------------------------------------------------------------------|---------------|-------------------------------------------------|
| `resource_group_name`                | The name of the Azure Resource Group where the resources will be created | string        | `"function-app-rg"`                                      |
| `location`                           | The Azure region where the resources will be deployed                 | string        | `"Central India"`                              |
| `storage_account_name`               | Storage account name if you have an existing storage account           | string        | `"terraformteststacc01"`                       |
| `storage_account_resource_group_name`| Storage account resource group name if you have an existing storage account | string     | `"function-app-rg"`                                      |
| `storage_name`                       | Storage account name to use if you don't have an existing storage account | string      | `null`                                          |
| `storage_account_access_key`         | Storage account access key to use if you don't have an existing storage account | string   | `null`                                          |
| `service_plan_name`                  | Name of the Azure App Service Plan                                     | string        | `"app-service-plan"`                           |
| `os_type`                            | Operating system type for the App Service Plan                         | string        | `"Windows"`                                     |
| `sku_name`                           | SKU name for the App Service Plan                                      | string        | `"Y1"`                                          |
| `function_apps`                      | Configuration for Azure Function Apps                                  | map(object)   | See below                                      |
| `identity_type`                      | Add an Identity (MSI) to the function app. Possible values are SystemAssigned or UserAssigned | string | `"SystemAssigned"`                      |
| `identity_ids`                       | User Assigned Identities IDs to add to Function App. Mandatory if type is UserAssigned | list(string) | `null`                                        |

#### Function App Specific Configuration

| Name                                     | Description                                           | Type     | Default | Required |
|------------------------------------------|-------------------------------------------------------|----------|---------|----------|
| always_on                         | Enable Always On for the Function App                                 | bool    | null    | No       |
| api_definition_url                | The URL for the API definition                                          | string  | null    | No       |
| api_management_api_id             | The API Management API ID                                               | string  | null    | No       |
| app_command_line                  | The command line for the application                                    | string  | null    | No       |
| app_scale_limit                   | The scale limit for the application                                     | number  | null    | No       |
| default_documents                 | List of default documents                                                | list(string) | null | No       |
| ftps_state                        | State of FTPS (FTP over SSL)                                            | string  | "Disabled" | No       |
| health_check_path                 | The path for health checks                                               | string  | null    | No       |
| health_check_eviction_time_in_min | The eviction time for health checks (in minutes)                         | number  | null    | No       |
| http2_enabled                     | Enable HTTP/2                                                            | bool    | null    | No       |
| load_balancing_mode               | The load balancing mode                                                  | string  | null    | No       |
| managed_pipeline_mode             | The managed pipeline mode                                                | string  | null    | No       |
| minimum_tls_version               | The minimum TLS version                                                  | string  | "1.2"   | No       |
| remote_debugging_enabled          | Enable remote debugging                                                  | bool    | false   | No       |
| remote_debugging_version          | The version of remote debugging                                          | string  | null    | No       |
| runtime_scale_monitoring_enabled  | Enable runtime scale monitoring                                          | bool    | null    | No       |
| use_32_bit_worker                 | Use 32-bit worker process                                                | bool    | null    | No       |
| websockets_enabled                | Enable WebSockets                                                        | bool    | false   | No       |
| application_insights_connection_string | Connection string for Application Insights                      | string  | null    | No       |
| application_insights_key               | Key for Application Insights                                    | string  | null    | No       |
| application_stack               | Stack configuration for the application                            | map(object({...})) | null | No       |
| cors                            | CORS configuration for the application                             | map(object({...})) | null | No       |
| app_service_logs                | Log configuration for the application                              | map(object({...})) | null | No       |
| ip_restriction                  | ip restriction for application                                     | map(object({...})) | null | No       |

This is an overview of the input variables and default values for the Terraform resource that deploys an Azure Function App. For more customization, please refer to the Terraform documentation.

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app


### Outputs

| Name                                      | Description                                                  | Type   |
|-------------------------------------------|--------------------------------------------------------------|--------|
| linux_web_app_default_site_hostname       | The Default Hostname associated with the Linux Web App.     | string |
| windows_web_app_default_site_hostname     | The Default Hostname associated with the Windows Web App.   | string |

## Authors

Module managed by [TO THE NEW Pvt. Ltd.](https://github.com/tothenew)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/tothenew/terraform-aws-template/blob/main/LICENSE) for full details.
