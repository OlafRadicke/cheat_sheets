Terraform cheat sheets
======================

Terraform install
-----------------

* [download terraform](https://www.terraform.io/downloads.html)

```bash
unzip ./terraform_0.12.18_linux_amd64.zip
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

External documentation
----------------------

* [Azure kubernets](https://www.terraform.io/docs/providers/azurerm/r/kubernetes_cluster.html)