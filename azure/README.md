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
...The here "id" is the "Subscription ID".

### List all azure accounts ###

```bash
az account list
```

### Get an existing service principal

``bash
az ad sp list --show-mine --query "[].{id:appId, tenant:appOwnerTenantId}"
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
[or@augsburg02 bootstrap_azure_aks]$ az vm list-sizes --location "westeurope" --output table
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
az vm image list
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
