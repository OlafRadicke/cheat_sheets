Azure cloud
===========

Installieren der Azure CLI
--------------------------

Under fedora:

Import the key of Microsoft repository.

```bash
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
```

Create the repository configuration of azure-cli:

```bash
sudo sh -c 'echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
```

And install over dnf:

```bash
sudo dnf install azure-cli
```

Login in azure cloud
--------------------

```bash
[or@augsburg03 cheat_sheets]$ az login
You have logged in. Now let us find all the subscriptions to which you have access...
[
  {
    "cloudName": "AzureCloud",
    "id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "isDefault": true,
    "name": "Pay-As-You-Go",
    "state": "Enabled",
    "tenantId": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "user": {
      "name": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
      "type": "user"
    }
  }
]
```

### List all azure accounts ###

```bash
az account list
```

Working with azure
------------------

### Ge the configuration of a Kubernets clouster ###

```bash
[or@augsburg03 ansible]$ az aks get-credentials --resource-group "name_of_your_resource_group" --name "name_of_your_kubernetes_cluster"
Merged "name_of_your_kubernetes_cluster" as current context in /home/or/.kube/config

```

### Open the Kubernetes deshbord ###

```bash
[or@augsburg03 local]$ az aks browse --resource-group name_of_your_resource_group --name name_of_your_resource_group
Merged "name_of_your_resource_group" as current context in /tmp/tmppvlruefk
Proxy running on http://127.0.0.1:8001/
Press CTRL+C to close the tunnel...

```

### Get pulic IPs ###

```bash
az network public-ip list
```

### Get limits of a location ###

```bash
[or@augsburg02 bootstrap_azure_aks]$ az vm list-usage --location westeurope  --output yaml
- currentValue: '0'
  limit: '2500'
  localName: Availability Sets
  name:
    localizedValue: Availability Sets
    value: availabilitySets
- currentValue: '0'
  limit: '10'
  localName: Total Regional vCPUs
  name:
    localizedValue: Total Regional vCPUs
    value: cores
- currentValue: '0'
  limit: '25000'
  localName: Virtual Machines
  name:
    localizedValue: Virtual Machines
    value: virtualMachines
[..]
```

External documentation
----------------------

* [Installieren der Azure CLI](https://docs.microsoft.com/de-de/cli/azure/install-azure-cli?view=azure-cli-latest)
* [Azure Provider: Authenticating using the Azure CLI](https://www.terraform.io/docs/providers/azurerm/guides/azure_cli.html)
* [Bereitstellen eines Azure Kubernetes Service-Clusters über die Azure-Befehlszeilenschnittstelle](https://docs.microsoft.com/de-de/azure/aks/kubernetes-walkthrough)
* [Installieren von Anwendungen mit Helm in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/de-de/azure/aks/kubernetes-helm)
* [Terraform azure provider](https://www.terraform.io/docs/providers/azurerm/index.html)
* [Application and service principal objects in Azure Active Directory](https://docs.microsoft.com/en-us/azure/active-directory/develop/app-objects-and-service-principals)