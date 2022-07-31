terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.15.0, < 4.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group" {
    name = "${var.prefix}-rg"
    location = var.location
}

resource "azurerm_storage_account" "storage_account" {
    name = "${var.prefix}afpctsa1"
    location = var.location
    resource_group_name = azurerm_resource_group.resource_group.name
    account_tier = "Standard"
    account_replication_type = "LRS"
}

resource "azurerm_service_plan" "service_plan" {
  name = "${var.prefix}-svcplan"
  resource_group_name = azurerm_resource_group.resource_group.name
  location = var.location
  os_type = "Linux"  
  sku_name = "Y1" // Y1
}

resource "azurerm_linux_function_app" "function_app" {
  name = "${var.prefix}"
  location = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  service_plan_id = azurerm_service_plan.service_plan.id
  storage_account_name = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
  
  
  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "python"
  }
  site_config {
      use_32_bit_worker = false
      application_stack {
      python_version = "3.9"
    }
  }
}
