variable "project_name_prefix" {
  description = "Used in tags cluster and nodes"
  type        = string
  default     = "dev"
}

variable "default_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default = {
    "Scope" : "database"
    "CreatedBy" : "Terraform"
  }
}

variable "common_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default = {
    Project    = "Azure_database",
    Managed-By = "TTN",
  }
}

variable "resource_group_name" {
  description = "The name of the Azure Resource Group where the resources will be created."
  type        = string
  default     = "gaurav"
}

variable "location" {
  description = "The Azure region where the resources will be deployed. E.g., 'East US', 'West Europe', etc."
  type        = string
  default     = "Central India"
}

variable "create_resource_group" {
  type    = bool
  default = false
}

variable "create_storage_account" {
  type    = bool
  default = false
}


variable "storage_account_name" {
  type = string
  default = "terraformteststacc01"
}

variable "storage_account_resource_group_name" {
  type = string
  default = "gaurav"
}
#####################################################################################################
###                                           Function App                                        ###
#####################################################################################################
variable "service_plan_name" {
  description = "Name of the Azure App Service Plan"
  type        = string
  default     = "example-app-service-plan"
}

variable "os_type" {
  description = "Operating system type for the App Service Plan"
  type        = string
  default     = "Linux"
}

variable "sku_name" {
  description = "SKU name for the App Service Plan"
  type        = string
  default     = "Y1"
}

variable "function_apps" {
  description = "Configuration for Azure Function Apps"
  type = map(object({
    name                        = string
    location                    = string
    public_network_access_enabled = bool
    functions_extension_version   = string
  }))
  default = {
    default_function_app = {
      name                        = "default-function-app-1"
      location                    = "Central India"
      public_network_access_enabled = true
      functions_extension_version = "~4"
    }
    default_function_app-2 = {
      name                        = "default-function-app"
      location                    = "Central India"
      public_network_access_enabled = true
      functions_extension_version = "~4"
    }
  }
}

variable "site_config" {
  description = "Site config for Function App. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#site_config. IP restriction attribute is not managed in this block."
  type        = any
  default     = {
    application_stack = {
      python_version              = "3.10"
    }
    }
}


variable "identity_type" {
  description = "Add an Identity (MSI) to the function app. Possible values are SystemAssigned or UserAssigned."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "User Assigned Identities IDs to add to Function App. Mandatory if type is UserAssigned."
  type        = list(string)
  default     = null
}