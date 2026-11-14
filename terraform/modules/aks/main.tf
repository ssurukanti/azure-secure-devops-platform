variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "node_count" { type = number }
variable "node_size" { type = string }
variable "subnet_id" { type = string }
variable "log_analytics_id" { type = string }
variable "tags" { type = map(string) }

resource "azurerm_kubernetes_cluster" "main" {
  name                = "aks-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks-${var.name}"

  default_node_pool {
    name           = "system"
    node_count     = var.node_count
    vm_size        = var.node_size
    vnet_subnet_id = var.subnet_id
  }

  identity { type = "SystemAssigned" }

  oms_agent { log_analytics_workspace_id = var.log_analytics_id }

  tags = var.tags
}

output "cluster_name" { value = azurerm_kubernetes_cluster.main.name }
output "kube_config" {
  value     = azurerm_kubernetes_cluster.main.kube_config_raw
  sensitive = true
}
