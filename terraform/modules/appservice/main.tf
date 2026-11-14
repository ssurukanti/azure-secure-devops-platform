variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "tags" { type = map(string) }

resource "azurerm_service_plan" "main" {
  name                = "asp-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "B1"
  tags                = var.tags
}

resource "azurerm_linux_web_app" "main" {
  name                = "app-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.main.id
  https_only          = true

  site_config {
    minimum_tls_version = "1.2"
    # Only Front Door should reach this app. See docs/security.md
    # for the x-fdid header restriction pattern.
  }

  tags = var.tags
}

output "default_hostname" { value = azurerm_linux_web_app.main.default_hostname }
output "app_id" { value = azurerm_linux_web_app.main.id }
