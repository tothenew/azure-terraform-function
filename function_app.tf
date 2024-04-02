resource "azurerm_service_plan" "app_service_plan" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name
   tags = {
    CreatedBy = "gaurav"
    Purpose   = "terraform test"
  }
}

resource "azurerm_linux_function_app" "linux_function_app" {
  for_each = var.os_type == "Linux" ? var.function_apps : {}
  
  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = each.value.location

  storage_account_name       = var.storage_name != null ? var.storage_name : data.azurerm_storage_account.storage_acc.0.name
  storage_account_access_key = var.storage_account_access_key != null ? var.storage_account_access_key : data.azurerm_storage_account.storage_acc.0.primary_access_key
  
  service_plan_id               = azurerm_service_plan.app_service_plan.id                                                
  public_network_access_enabled = each.value.public_network_access_enabled
  functions_extension_version   = each.value.functions_extension_version

  dynamic "site_config" {
    for_each = [var.site_config]

    content {
      always_on                         = lookup(site_config.value, "always_on", null)
      api_definition_url                = lookup(site_config.value, "api_definition_url", null)
      api_management_api_id             = lookup(site_config.value, "api_management_api_id", null)
      app_command_line                  = lookup(site_config.value, "app_command_line", null)
      app_scale_limit                   = lookup(site_config.value, "app_scale_limit", null)
      default_documents                 = lookup(site_config.value, "default_documents", null)
      ftps_state                        = lookup(site_config.value, "ftps_state", "Disabled")
      health_check_path                 = lookup(site_config.value, "health_check_path", null)
      health_check_eviction_time_in_min = lookup(site_config.value, "health_check_eviction_time_in_min", null)
      http2_enabled                     = lookup(site_config.value, "http2_enabled", null)
      load_balancing_mode               = lookup(site_config.value, "load_balancing_mode", null)
      managed_pipeline_mode             = lookup(site_config.value, "managed_pipeline_mode", null)
      minimum_tls_version               = lookup(site_config.value, "minimum_tls_version", lookup(site_config.value, "min_tls_version", "1.2"))
      remote_debugging_enabled          = lookup(site_config.value, "remote_debugging_enabled", false)
      remote_debugging_version          = lookup(site_config.value, "remote_debugging_version", null)
      runtime_scale_monitoring_enabled  = lookup(site_config.value, "runtime_scale_monitoring_enabled", null)
      use_32_bit_worker                 = lookup(site_config.value, "use_32_bit_worker", null)
      websockets_enabled                = lookup(site_config.value, "websockets_enabled", false)
      
      application_insights_connection_string = lookup(site_config.value, "application_insights_connection_string", null)
      application_insights_key               = lookup(site_config.value, "application_insights_key", false)


    dynamic "application_stack" {
        for_each = lookup(site_config.value, "application_stack", null) == null ? [] : ["application_stack"]
        content {
          dynamic "docker" {
            for_each = lookup(var.site_config.application_stack, "docker", null) == null ? [] : ["docker"]
            content {
              registry_url      = var.site_config.application_stack.docker.registry_url
              image_name        = var.site_config.application_stack.docker.image_name
              image_tag         = var.site_config.application_stack.docker.image_tag
              registry_username = lookup(var.site_config.application_stack.docker, "registry_username", null)
              registry_password = lookup(var.site_config.application_stack.docker, "registry_password", null)
            }
          }

          dotnet_version              = lookup(var.site_config.application_stack, "dotnet_version", null)
          use_dotnet_isolated_runtime = lookup(var.site_config.application_stack, "use_dotnet_isolated_runtime", null)

          java_version            = lookup(var.site_config.application_stack, "java_version", null)
          node_version            = lookup(var.site_config.application_stack, "node_version", null)
          python_version          = lookup(var.site_config.application_stack, "python_version", null)
          powershell_core_version = lookup(var.site_config.application_stack, "powershell_core_version", null)

          use_custom_runtime = lookup(var.site_config.application_stack, "use_custom_runtime", null)
        }
      }

    dynamic "cors" {
        for_each = lookup(site_config.value, "cors", null) != null ? ["cors"] : []
        content {
          allowed_origins     = lookup(site_config.value.cors, "allowed_origins", [])
          support_credentials = lookup(site_config.value.cors, "support_credentials", false)
        }
      }

    dynamic "app_service_logs" {
        for_each = lookup(site_config.value, "app_service_logs", null) != null ? ["app_service_logs"] : []
        content {
          disk_quota_mb         = lookup(site_config.value.app_service_logs, "disk_quota_mb", null)
          retention_period_days = lookup(site_config.value.app_service_logs, "retention_period_days", null)
        }
      }
   } 


}

dynamic "identity" {
    for_each = var.identity_type != null ? ["identity"] : []
    content {
      type = var.identity_type
      identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
    }
  }
 tags = {
    CreatedBy = "gaurav"
    Purpose   = "terraform test"
  }
}


resource "azurerm_windows_function_app" "window_function_app" {
  for_each = var.os_type == "Windows" ? var.function_apps : {}

  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = each.value.location
  
  storage_account_name       = var.storage_name != null ? var.storage_name : data.azurerm_storage_account.storage_acc.0.name
  storage_account_access_key = var.storage_account_access_key != null ? var.storage_account_access_key : data.azurerm_storage_account.storage_acc.0.primary_access_key
  
  service_plan_id     = azurerm_service_plan.app_service_plan.id                                                
  public_network_access_enabled = each.value.public_network_access_enabled
  functions_extension_version = each.value.functions_extension_version

  dynamic "site_config" {
    for_each = [var.site_config]

    content {
      always_on                         = lookup(site_config.value, "always_on", null)
      api_definition_url                = lookup(site_config.value, "api_definition_url", null)
      api_management_api_id             = lookup(site_config.value, "api_management_api_id", null)
      app_command_line                  = lookup(site_config.value, "app_command_line", null)
      app_scale_limit                   = lookup(site_config.value, "app_scale_limit", null)
      default_documents                 = lookup(site_config.value, "default_documents", null)
      ftps_state                        = lookup(site_config.value, "ftps_state", "Disabled")
      health_check_path                 = lookup(site_config.value, "health_check_path", null)
      health_check_eviction_time_in_min = lookup(site_config.value, "health_check_eviction_time_in_min", null)
      http2_enabled                     = lookup(site_config.value, "http2_enabled", null)
      load_balancing_mode               = lookup(site_config.value, "load_balancing_mode", null)
      managed_pipeline_mode             = lookup(site_config.value, "managed_pipeline_mode", null)
      minimum_tls_version               = lookup(site_config.value, "minimum_tls_version", lookup(site_config.value, "min_tls_version", "1.2"))
      remote_debugging_enabled          = lookup(site_config.value, "remote_debugging_enabled", false)
      remote_debugging_version          = lookup(site_config.value, "remote_debugging_version", null)
      runtime_scale_monitoring_enabled  = lookup(site_config.value, "runtime_scale_monitoring_enabled", null)
      use_32_bit_worker                 = lookup(site_config.value, "use_32_bit_worker", null)
      websockets_enabled                = lookup(site_config.value, "websockets_enabled", false)
      
      application_insights_connection_string = lookup(site_config.value, "application_insights_connection_string", null)
      application_insights_key               = lookup(site_config.value, "application_insights_key", false)


    dynamic "application_stack" {
        for_each = lookup(site_config.value, "application_stack", null) == null ? [] : ["application_stack"]
        content {
          dotnet_version              = lookup(var.site_config.application_stack, "dotnet_version", null)
          use_dotnet_isolated_runtime = lookup(var.site_config.application_stack, "use_dotnet_isolated_runtime", null)

          java_version            = lookup(var.site_config.application_stack, "java_version", null)
          node_version            = lookup(var.site_config.application_stack, "node_version", null)
          powershell_core_version = lookup(var.site_config.application_stack, "powershell_core_version", null)
          use_custom_runtime = lookup(var.site_config.application_stack, "use_custom_runtime", null)
        }
      }

    dynamic "cors" {
        for_each = lookup(site_config.value, "cors", null) != null ? ["cors"] : []
        content {
          allowed_origins     = lookup(site_config.value.cors, "allowed_origins", [])
          support_credentials = lookup(site_config.value.cors, "support_credentials", false)
        }
      }

    dynamic "app_service_logs" {
        for_each = lookup(site_config.value, "app_service_logs", null) != null ? ["app_service_logs"] : []
        content {
          disk_quota_mb         = lookup(site_config.value.app_service_logs, "disk_quota_mb", null)
          retention_period_days = lookup(site_config.value.app_service_logs, "retention_period_days", null)
        }
      }
   } 


}

dynamic "identity" {
    for_each = var.identity_type != null ? ["identity"] : []
    content {
      type = var.identity_type
      identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
    }
  }
  
 tags = {
    CreatedBy = "gaurav"
    Purpose   = "terraform test"
  }
}