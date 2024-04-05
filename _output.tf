output "linux_function_app_default_hostnames" {
  description = "The Default Hostnames associated with the Azure Function Apps for Linux OS"
  value = var.os_type == "Linux" ? {
    for function_app_key, function_app in azurerm_linux_function_app.linux_function_app :
    function_app_key => format("https://%s/", function_app.default_hostname)
  } : null
}

output "windows_function_app_default_hostnames" {
  description = "The Default Hostnames associated with the Azure Function Apps for winfow OS"
  value = var.os_type == "Windows" ? {
    for function_app_key, function_app in azurerm_windows_function_app.window_function_app :
    function_app_key => format("https://%s/", function_app.default_hostname)
  } : null
}
