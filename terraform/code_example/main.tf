resource "azurerm_resource_group" "FFk8sRG" {
    name     = "FFk8sRG"
    location = var.location
}

resource "azuread_application" "k8stestapplication" {
    name                     = "k8stestapplication"
}

resource "azuread_service_principal" "k8stestapplication" {
    application_id       = azuread_application.k8stestapplication.application_id
}

resource "azuread_service_principal_password" "k8stestapplication" {
    service_principal_id = azuread_service_principal.k8stestapplication.id
    value                = var.secret_service_principal_password
    end_date             = "{{ azuread_service_principal_password_end_date }}"
}

output "azuread_service_principal_output" {
    value = azuread_service_principal.k8stestapplication
}


resource "azurerm_kubernetes_cluster" "ffk8s" {
    name                = "ffk8s"
    location            = azurerm_resource_group.FFk8sRG.location
    resource_group_name = azurerm_resource_group.FFk8sRG.name
    dns_prefix          = "k8stest"

    linux_profile {
        admin_username = "ffuser"

        ssh_key {
            key_data = file(var.ssh_public_key)
        }
    }

    default_node_pool {
        name            = "agentpool"
        node_count      = var.agent_count
        vm_size         = "Standard_B1ls"
        # vm_size         = "Standard_DS1_v2"
    }

    service_principal {
        client_id       = azuread_application.k8stestapplication.application_id
        client_secret   = var.secret_service_principal_password
    }

    tags = {
        Environment = "Development"
    }
}