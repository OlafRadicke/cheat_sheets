Terraform cheat sheets
======================

Terraform install
-----------------

Check available version on [terraform download site](https://www.terraform.io/downloads.html).

```bash
TERRAFORMVERSION=0.12.24 && \
cd /tmp && \
wget https://releases.hashicorp.com/terraform/${TERRAFORMVERSION}/terraform_${TERRAFORMVERSION}_linux_amd64.zip && \
unzip ./terraform_${TERRAFORMVERSION}_linux_amd64.zip && \
sudo mv ./terraform /usr/local/bin/
```

Basic commands
--------------

Init enter:

```bash
terraform init
```

Run / roll out setup with terraform enter:

```bash
terraform apply
```

Clean up / destroy setup enter:

```bash
terraform destroy
```

State files on network storage
------------------------------

```yaml
provider "azurerm" {
  version           = "=2.20.0"
  features          {}
}

# Configure the Microsoft Azure Active Directory Provider
provider "azuread" {
    version         = "=0.4.0"
    subscription_id = "{{ secret_subscription_id }}"
    tenant_id       = "{{ secret_tenant_id }}"
}

resource "azurerm_resource_group" "{{ azurerm_resource_group }}" {
  name                       = "{{ azurerm_resource_group }}"
  location                   = "{{ aks_location }}"
}

resource "azurerm_storage_account" "{{ storage_account_name }}" {
  name                       = "{{ storage_account_name }}"
  resource_group_name        = azurerm_resource_group.{{ azurerm_resource_group }}.name
  location                   = azurerm_resource_group.{{ azurerm_resource_group }}.location
  account_tier               = "Standard"
  account_replication_type   = "LRS"

}

{% for container in state_backend.container %}

resource "azurerm_storage_container" "{{ container }}" {
  name                       = "{{ container }}"
  storage_account_name       = azurerm_storage_account.{{ storage_account_name }}.name
  container_access_type      = "private"
}

{% endfor %}

```

Remove Terraform lock file
--------------------------

```bash
terraform force-unlock f9dc97b0-c0cc-b514-fdff-b019d4edd117
```

Resync Terraform state
----------------------

```bash
terraform import azurerm_container_registry.globelacr001 /subscriptions/XXX/resourceGroups/global_docker_repo/providers/xxx/globelacr001
```

External documentation
----------------------

* [Azure kubernets](https://www.terraform.io/docs/providers/azurerm/r/kubernetes_cluster.html)