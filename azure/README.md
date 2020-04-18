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

Login
-----

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

Sub sites
---------

* []()


External documentation
----------------------

* [Installieren der Azure CLI](https://docs.microsoft.com/de-de/cli/azure/install-azure-cli?view=azure-cli-latest)
* [Azure Provider: Authenticating using the Azure CLI](https://www.terraform.io/docs/providers/azurerm/guides/azure_cli.html)
* [Bereitstellen eines Azure Kubernetes Service-Clusters über die Azure-Befehlszeilenschnittstelle](https://docs.microsoft.com/de-de/azure/aks/kubernetes-walkthrough)
* [Installieren von Anwendungen mit Helm in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/de-de/azure/aks/kubernetes-helm)
* [Terraform azure provider](https://www.terraform.io/docs/providers/azurerm/index.html)
* [Application and service principal objects in Azure Active Directory](https://docs.microsoft.com/en-us/azure/active-directory/develop/app-objects-and-service-principals)