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
