output "resource_group" {
  value = azurerm_resource_group.main.name
}

output "aks_cluster_name" {
  value = module.aks.cluster_name
}

output "aks_kube_config_command" {
  value = "az aks get-credentials --resource-group ${azurerm_resource_group.main.name} --name ${module.aks.cluster_name}"
}

output "front_door_endpoint" {
  value = module.front_door.endpoint_hostname
}

output "key_vault_uri" {
  value = module.key_vault.vault_uri
}
