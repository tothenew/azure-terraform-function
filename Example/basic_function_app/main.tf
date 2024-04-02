module "Azure_Function_App" {
   source = "git::https://github.com/tothenew/azure-terraform-function.git"

   resource_group_name = "gaurav"
   location            = "Central India"

   storage_account_name = "st11"
   storage_account_resource_group_name = "gaurav"
   
   ################# App Service Plan #############################
   service_plan_name = "app-service-plan-1"
   os_type  = "Linux"
   sku_name = "B2"
  
  #################### function App ###############################
   function_apps = {
      function_app-1 = {
      name                        = "function-app-1"
      location                    = "Central India"
      public_network_access_enabled = true
      functions_extension_version = "~4"
    }
    function_app-2 = {
      name                        = "function-app-2"
      location                    = "Central India"
      public_network_access_enabled = true
      functions_extension_version = "~4"
    }
   }

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

    application_stack = {
      python_version              = "3.10"
    }
   }
  
}