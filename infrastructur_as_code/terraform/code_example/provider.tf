
provider "azurerm" {
  version = "=2.20.0"
  features {}
}

# Configure the Microsoft Azure Active Directory Provider
provider "azuread" {
    version         = "=0.4.0"
    subscription_id = var.secret_subscription_id
    tenant_id       = var.secret_tenant_id
}


# Um dan Status in der Azure-Cloud abzulegen
# terraform {
#     backend "azurerm" {}
# }
