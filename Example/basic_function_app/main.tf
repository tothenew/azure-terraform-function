terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "terraformtesting0001112"
  resource_group_name      = "function-app-rg"
  location                 = "Central India"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

module "Azure_Function_App" {
   source = "git::https://github.com/tothenew/azure-terraform-function.git"

# set the value of create_resource_group = false if you have a existing resource group then simply pass the name and location of resource group
   create_resource_group = true
   resource_group_name = "function-app-rg"
   location            = "Central India"

# if you don't have a existing storage account then use this configuration
   create_storage_account     = true
   storage_name               = azurerm_storage_account.storage_account.name
   storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key

# if you have a existing storage account then use this configuration
#    create_storage_account  = false
#    storage_account_name = "terraformteststacc01"
#    storage_account_resource_group_name = "gaurav"
     
   
   ################# App Service Plan #############################
   service_plan_name = "app-service-plan-1"
   os_type  = "Linux"
   sku_name = "B2"
  
  #################### function App ###############################
   function_apps = {
      function_app-1 = {
      name                        = "function-app-1000111"
      location                    = "Central India"
      public_network_access_enabled = true
      functions_extension_version = "~4"
      client_certificate_mode     = null
      client_certificate_enabled  = null


    site_config = {
    always_on                   = true
    http2_enabled               = false
    load_balancing_mode         = "LeastRequests"
    managed_pipeline_mode       = "Integrated"
    minimum_tls_version         = "1.2"
    remote_debugging_enabled    = false
    scm_minimum_tls_version     = "1.2"
    scm_use_main_ip_restriction = false
    websockets_enabled          = false
    }
    application_stack = {
      python_version              = "3.10"
    }
    app_service_logs = null
    cors = null
    ip_restriction = null
    # function_app-2 = {
    #   name                        = "function-app-2"
    #   location                    = "Central India"
    #   public_network_access_enabled = true
    #   functions_extension_version = "~4"
    # }
     }
  }
  identity_type  = "SystemAssigned"
  #provide 'identity_ids' if identity_type is  'UserAssigned'
  #identity_ids  = null

  default_tags = {
    "Scope" : "function_app"
    "CreatedBy" : "Terraform"
  }
    
  common_tags = {
    Project    = "Azure_Function_app",
    Managed-By = "TTN",
  }

  project_name_prefix = "dev"
}

