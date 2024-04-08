variable "project_name_prefix" {
  description = "Used in tags cluster and nodes"
  type        = string
  default     = "dev"
}

variable "default_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default = {
    "Scope" : "function_app"
    "CreatedBy" : "Terraform"
  }
}

variable "common_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default = {
    Project    = "Azure_Function_app",
    Managed-By = "TTN",
  }
}

variable "resource_group_name" {
  description = "The name of the Azure Resource Group where the resources will be created."
  type        = string
  default     = "function-app-rg"
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
  description = " storage account name if  have an existing storage account"
  type = string
  default = null
}

variable "storage_account_resource_group_name" {
  description = " storage account resource group name if have an existing storage account"
  type = string
  default = null
}

variable "storage_name" {
  description = "storage account name to use if not don't have an existing storage account"
  type        = string
  default     = null
}

variable "storage_account_access_key" {
  description = "storage account access key to use if not don't have an existing storage account"
  type        = string
  default     = null
}




#####################################################################################################
###                                           Function App                                        ###
#####################################################################################################
variable "service_plan_name" {
  description = "Name of the Azure App Service Plan"
  type        = string
  default     = "app-service-plan"
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
    client_certificate_enabled     = bool
    client_certificate_mode       = string
    site_config                   = any
    application_stack             = any
    cors                          = any
    app_service_logs              = any
    ip_restriction                = any
  }))
  default = {
    function_app_1 = {
      name                        = "function-app-1"
      location                    = "Central India"
      public_network_access_enabled = true
      functions_extension_version = "~4" 
      client_certificate_enabled  = null  
      client_certificate_mode     = null
      site_config = {
            # always_on = true
            # http2_enabled = true
            # # application_insights_connection_string = ""
            # # application_insights_key       = ""
            # ip_restriction_default_action = "Allow"
      }
      application_stack = {
      node_version              = "18"
    #  python_version              = "3.10"
    }
    cors = null
    app_service_logs = null
   ip_restriction = null
  #  {
  #         action         = "Allow"
  #         name           = "My IP Restriction"
  #         priority       = 100
  #         ip_address     = "192.168.1.1/32"
  #         service_tag    = null
  #         headers        = null
  #         virtual_network_subnet_id = null
  #     }
    }
    # function_app_2 = {
    #   name                        = "default-function-app-1"
    #   location                    = "Central India"
    #   public_network_access_enabled = true
    #   functions_extension_version = "~4"
    #   site_config = {
    #         always_on = true
    #         http2_enabled = false
    #   }
    #   application_stack = {
    #   python_version              = "3.10"
    # }
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
