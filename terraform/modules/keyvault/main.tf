resource "azurerm_key_vault" "main" {
  name                       = "kv-${replace(var.name, "-", "")}"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false # set true in prod
  enable_rbac_authorization  = true  # RBAC, not access policies
  tags                       = var.tags
}
