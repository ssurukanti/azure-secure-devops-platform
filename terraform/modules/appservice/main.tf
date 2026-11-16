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

  app_settings = var.app_insights_connection_string == null ? {} : {
    APPLICATIONINSIGHTS_CONNECTION_STRING = var.app_insights_connection_string
    APPINSIGHTS_INSTRUMENTATIONKEY        = var.app_insights_instrumentation_key
  }

  site_config {
    minimum_tls_version = "1.2"
    # Only Front Door should reach this app. See docs/security.md
    # for the x-fdid header restriction pattern.
  }

  tags = var.tags
}
