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

External documentation
----------------------

* [Azure kubernets](https://www.terraform.io/docs/providers/azurerm/r/kubernetes_cluster.html)