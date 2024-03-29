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

or

```bash
TENANT_ID=$(az account show --query tenantId | tr -d \")
az login  --tenant $TENANT_ID
```

...The here "id" is the "Subscription ID".

### List all azure accounts ###

```bash
az account list
```

### Service principals ###

Get an existing service principal:

```bash
az ad sp list --output table --all
```

Get

```bash
az ad app list --output table
```

Create an Application:

```bash
az ad app create --display-name OlafTestApp --native-app
{
  "acceptMappedClaims": null,
  "addIns": [],
  "allowGuestsSignIn": null,
  "allowPassthroughUsers": null,
  "appId": "1ed1fa06-b97d-490c-9bc7-b1c8ec7cf471",
  "appLogoUrl": null,
  "appPermissions": null,
  "appRoles": [],
  "applicationTemplateId": null,
  [...]
```

Create service principal with password:

```bash
$ az ad sp create-for-rbac --name SPofOlaf

Changing "SPofOlaf" to a valid URI of "http://SPofOlaf", which is the required format used for service principal names
Creating a role assignment under the scope of "/subscriptions/7de97db4-XXXX-XXXX-XXXX-be87409f4f7e"
  Retrying role assignment creation: 1/36
{
  "appId": "3d73be36-XXXX-XXXX-XXXX-ee32dfed9606",
  "displayName": "SPofOlaf",
  "name": "http://SPofOlaf",
  "password": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
  "tenant": "4ba9c756-XXXX-XXXX-XXXX-b205e570f62b"
}
```

Sign in using a service principal

```bash
export AZURE_CLIENT_ID="3d73be36-XXXX-XXXX-XXXX-ee32dfed9606"
export AZURE_SECRET="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
export AZURE_SUBSCRIPTION_ID="7de97db4-XXXX-XXXX-XXXX-be87409f4f7e"
export AZURE_TENANT="4ba9c756-XXXX-XXXX-XXXX-b205e570f62b"

az login --service-principal \
  --username $AZURE_CLIENT_ID \
  --password $AZURE_SECRET \
  --tenant $AZURE_TENANT
```

The Ansible modules will look for credentials in ```$HOME/.azure/credentials```. It will look as follows:

```ini
[default]
subscription_id="7de97db4-XXXX-XXXX-XXXX-be87409f4f7e"
client_id="3d73be36-XXXX-XXXX-XXXX-ee32dfed9606"
secret="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
tenant="4ba9c756-XXXX-XXXX-XXXX-b205e570f62b"
```

Add service principal reading access for an App:

```bash
az role assignment create --assignee 1ed1fa06-b97d-490c-9bc7-b1c8ec7cf471 --role Reader
```

Delete a  service principal:

```bash
[radickeo@localhost cheat_sheets]$ az ad sp delete --id $AZURE_CLIENT_ID

Removing role assignments
```

Working with azure
------------------

### Ge the configuration of a Kubernets clouster ###

```bash
$ az aks get-credentials --resource-group "name_of_your_resource_group" --name "name_of_your_kubernetes_cluster"

Merged "name_of_your_kubernetes_cluster" as current context in /home/or/.kube/config

```

### Open the Kubernetes deshbord ###

```bash
$ az aks browse --resource-group name_of_your_resource_group --name name_of_your_resource_group

Merged "name_of_your_resource_group" as current context in /tmp/tmppvlruefk
Proxy running on http://127.0.0.1:8001/
Press CTRL+C to close the tunnel...

```

### Get pulic IPs ###

```bash
az network public-ip list
```

### Get vm limits of a location ###

```bash
az vm list-usage --location westeurope  --output table

Name                               CurrentValue    Limit
---------------------------------  --------------  -------
Availability Sets                  0               2500
Total Regional vCPUs               0               10
Virtual Machines                   0               25000
Virtual Machine Scale Sets         0               2500
Dedicated vCPUs                    0               3000
Total Regional Low-priority vCPUs  0               10
Standard Dv2 Family vCPUs          0               10
Basic A Family vCPUs               0               10
Standard A0-A7 Family vCPUs        0               10
[...]
```
### Get network limits

```bash
az network list-usages --location "Germany West Central" --output table

Name                                                          CurrentValue    Limit
------------------------------------------------------------  --------------  ----------
Virtual Networks                                              1               1000
Static Public IP Addresses                                    0               10
Network Security Groups                                       1               5000
Public IP Addresses                                           8               10
Public Ip Prefixes                                            0               2147483647
Nat Gateways                                                  0               2147483647
[...]
```

Get list of vm sizes
--------------------

```bash
$ az vm list-sizes --location "westeurope" --output table

MaxDataDiskCount    MemoryInMb    Name                    NumberOfCores    OsDiskSizeInMb    ResourceDiskSizeInMb
------------------  ------------  ----------------------  ---------------  ----------------  ----------------------
2                   512           Standard_B1ls           1                1047552           4096
2                   2048          Standard_B1ms           1                1047552           4096
2                   1024          Standard_B1s            1                1047552           4096
4                   8192          Standard_B2ms           2                1047552           16384
4                   4096          Standard_B2s            2                1047552           8192
8                   16384         Standard_B4ms           4                1047552           32768
16                  32768         Standard_B8ms           8                1047552           65536
16                  49152         Standard_B12ms          12               1047552           98304
32                  65536         Standard_B16ms          16               1047552           131072
```

List supported regions
----------------------

...for the current subscription and only in germany:

```bash
$ az account list-locations  --output table  | grep german

Germany West Central      germanywestcentral   (Europe) Germany West Central
Germany North             germanynorth         (Europe) Germany North
```


Price examples
--------------

|name            | cors | ram | disk | price |
|----------------|------|-----|------|-------|
| Standard_A1_v2 | 1    | 2   | 10   | 0,008 |
| Standard_A2_v2 | 2    | 4   | 20   | 0,017 |
| Standard_B2ms  | 2    | 8   | 16   | 0,037 |
| Standard_D2_v3 | 2    | 8   | 16   | 0,051 |
| Standard_D4_v3 | 4    | 16  | 100  | 0,102 |
| Standard_H8    | 8    | 56  | 1000 | 0,492 |


Get image list
--------------

```bash
$ az vm image list --location westeurope  --output table

You are viewing an offline list of images, use --all to retrieve an up-to-date list
Offer          Publisher               Sku                 UrnAlias
-------------  ----------------------  ------------------  -------------------
CentOS         OpenLogic               7.5                 CentOS
CoreOS         CoreOS                  Stable              CoreOS
debian-10      Debian                  10                  Debian
openSUSE-Leap  SUSE                    42.3                openSUSE-Leap
RHEL           RedHat                  7-LVM               RHEL
SLES           SUSE                    15                  SLES
UbuntuServer   Canonical               18.04-LTS           UbuntuLTS

```

Get list of disks
-----------------

```bash
$ az disk list --out table
Name                                                      ResourceGroup        Location            Zones    Sku           OsType    SizeGb    ProvisioningState
--------------------------------------------------------  -------------------  ------------------  -------  ------------  --------  --------  -------------------
demo-pki-01-demo-pki-ac-01-persist                        DEMO-PKI-01-PERSIST  germanywestcentral           Standard_LRS  Linux     1         Succeeded
demo-pki-01-demo-pki-ac-02-persist                        DEMO-PKI-01-PERSIST  germanywestcentral           Standard_LRS  Linux     1         Succeeded
demo-pki-ac-01_OsDisk_1_438b6240bc5c44509f2dcbb23e57215b  DEMO-PKI-01          germanywestcentral           Premium_LRS   Linux     30        Succeeded
demo-pki-ac-02_OsDisk_1_cab5f29d74a54c4a85a3c0b1d3237a83  DEMO-PKI-01          germanywestcentral           Premium_LRS   Linux     30        Succeeded

```

### Azure pricing calculator ###

See: [this site](https://azure.microsoft.com/de-de/pricing/calculator/)


External documentation
----------------------

* [Installieren der Azure CLI](https://docs.microsoft.com/de-de/cli/azure/install-azure-cli?view=azure-cli-latest)
* [Azure Provider: Authenticating using the Azure CLI](https://www.terraform.io/docs/providers/azurerm/guides/azure_cli.html)
* [Bereitstellen eines Azure Kubernetes Service-Clusters über die Azure-Befehlszeilenschnittstelle](https://docs.microsoft.com/de-de/azure/aks/kubernetes-walkthrough)
* [Installieren von Anwendungen mit Helm in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/de-de/azure/aks/kubernetes-helm)
* [Terraform azure provider](https://www.terraform.io/docs/providers/azurerm/index.html)
* [Application and service principal objects in Azure Active Directory](https://docs.microsoft.com/en-us/azure/active-directory/develop/app-objects-and-service-principals)
