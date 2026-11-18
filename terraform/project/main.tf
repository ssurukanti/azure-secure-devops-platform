locals {
  name = "${var.project}-${var.environment}"
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${local.name}"
  location = var.location
  tags     = var.tags
}

module "vnet" {
  source              = "../modules/vnet"
  name                = local.name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

module "log_analytics" {
  source              = "../modules/log-analytics"
  name                = local.name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

module "key_vault" {
  source              = "../modules/keyvault"
  name                = local.name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

module "aks" {
  source              = "../modules/aks"
  name                = local.name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  node_count          = var.aks_node_count
  node_size           = var.aks_node_size
  subnet_id           = module.vnet.aks_subnet_id
  log_analytics_id    = module.log_analytics.workspace_id
  tags                = var.tags
}

module "app_insights" {
  source              = "../modules/appinsights"
  name                = local.name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  log_analytics_id    = module.log_analytics.workspace_id
  tags                = var.tags
}

module "app_service" {
  source                           = "../modules/appservice"
  name                             = local.name
  location                         = var.location
  resource_group_name              = azurerm_resource_group.main.name
  app_insights_connection_string   = module.app_insights.connection_string
  app_insights_instrumentation_key = module.app_insights.instrumentation_key
  tags                             = var.tags
}

module "front_door" {
  source              = "../modules/frontdoor"
  name                = local.name
  resource_group_name = azurerm_resource_group.main.name
  app_service_host    = module.app_service.default_hostname
  tags                = var.tags
}
