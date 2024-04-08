output "linux_function_app_default_hostnames" {
  description = "The Default Hostnames associated with the Azure Function Apps for Linux OS"
  value = module.Azure_Function_App.linux_function_app_default_hostnames

}

output "windows_function_app_default_hostnames" {
  description = "The Default Hostnames associated with the Azure Function Apps for winfow OS"
  value = module.Azure_Function_App.windows_function_app_default_hostnames
   
}