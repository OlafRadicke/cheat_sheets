PULUMI
======

- [PULUMI](#pulumi)
	- [INSTALL PULUMI](#install-pulumi)
	- [BACKENDS](#backends)
		- [GOOGLE](#google)
		- [AZURE](#azure)
		- [GENERIC AWS COMPATIBLE S3](#generic-aws-compatible-s3)
	- [HANDLE PULUNI PASSWORD](#handle-puluni-password)
	- [CREATE A NEW PULUMI PROJECT](#create-a-new-pulumi-project)
	- [DEPLOY STACK](#deploy-stack)
	- [ADD A SECRET](#add-a-secret)
	- [LIST SECRET](#list-secret)
	- [YAML SUPPORT](#yaml-support)
	- [HELM CHART SUPPORT](#helm-chart-support)
	- [REMOVE STACK](#remove-stack)
	- [PULUMI WATCH](#pulumi-watch)
	- [REFRESH THE RESOURCES IN A STACK](#refresh-the-resources-in-a-stack)
	- [TROUBLESHOOTING](#troubleshooting)
	- [READ AND CHANGE YAML FILES](#read-and-change-yaml-files)
	- [CREATE KUBERNETES SECRETS](#create-kubernetes-secrets)


INSTALL PULUMI
--------------

See: [https://www.pulumi.com/docs/install/](https://www.pulumi.com/docs/install/)

```bash
curl -fsSL https://get.pulumi.com | sh
```

BACKENDS
--------

### GOOGLE


1. Install [CLI](https://cloud.google.com/docs/authentication/provide-credentials-adc?hl=de#how-to)
2. Create Google Bucket
3. Login in Google ```gcloud auth login```
4. Change project ```gcloud config set project pulumi-prod```
5. Pulumi login: ```pulumi login gs://pulumi-atlantic-ocean```


### AZURE

See

- [installation-configuration](https://www.pulumi.com/registry/packages/azure/installation-configuration/)
- [state](https://www.pulumi.com/docs/concepts/state/)

```bash
$ pulumi config set azure:clientId <clientID>
$ pulumi config set azure:clientSecret <clientSecret> --secret
$ pulumi config set azure:tenantId <tenantID>
$ pulumi config set azure:subscriptionId <subscriptionId>
```

### GENERIC AWS COMPATIBLE S3


```bash
$ PULUMI_CONFIG_PASSPHRASE='XXXXXXXXXXX'
$ AWS_ACCESS_KEY_ID=XXXXXXXXX
$ AWS_SECRET_ACCESS_KEY=XXXXXXXXX
$ pulumi login 's3://pulumi?region=us-west-1&endpoint=us-west-1.storage.impossibleapi.net'
```

HANDLE PULUNI PASSWORD
----------------------

Set the Environment variables `PULUMI_CONFIG_PASSPHRASE` or create
an passwordfile under and `${HOME}/.ssh/quakers-social/pulumi` and
set `PULUMI_CONFIG_PASSPHRASE_FILE=${HOME}/.ssh/quakers-social/pulumi`
and than enter the script:


CREATE A NEW PULUMI PROJECT
---------------------------

To use the passphrase secrets provider with the pulumi.com backend, use:

Example for Kubernetes

```bash
pulumi new kubernetes-go \
	--description="k3s IaC of baltic-sea" \
	--name="baltic-sea" \
	--secrets-provider=passphrase \
	--stack="prod"
```

Example for Azure Cliud

```bash
$ pulumi new azure-go \
        --description="IaC of Azur" \
        --name="azure" \
        --secrets-provider=passphrase \
        --stack="prod"
```

Alternative for other templates:

- "kubernetes-typescript"
- "kubernetes-javascript"
- "kubernetes-python"
- "kubernetes-yaml"


See more: [www.pulumi.com/docs](https://www.pulumi.com/docs/cli/commands/pulumi_new/)


DEPLOY STACK
------------

Interactive:

```bash
pulumi up
```

Non interactive:

```bash
PULUMI_CONFIG_PASSPHRASE_FILE=${HOME}/.ssh/pulumi-passwd \
pulumi up --yes

```

See [pulumi.com/docs](https://www.pulumi.com/docs/cli/commands/pulumi_up/)

ADD A SECRET
------------

```bash
pulumi config set --secret oauth2ProxyclientSecret XXXXXXXX
```

LIST SECRET
-----------

```bash
pulumi config  --show-secrets
```


YAML SUPPORT
------------

See: [pulumi.com/docs](https://www.pulumi.com/docs/using-pulumi/adopting-pulumi/migrating-to-pulumi/from-kubernetes/)


HELM CHART SUPPORT
------------------

See: [pulumi.com/registry](https://www.pulumi.com/registry/packages/kubernetes/api-docs/helm/v3/chart/)


REMOVE STACK
------------

```bash
PULUMI_CONFIG_PASSPHRASE_FILE=${HOME}/.ssh/pulumi-passwd \
pulumi destroy
pulumi stack rm
```

PULUMI WATCH
------------

This command watches the working directory or specified paths for the current project and updates the active stack whenever the project changes. In parallel, logs are collected for all resources in the stack and displayed along with update progress.

REFRESH THE RESOURCES IN A STACK
--------------------------------

This command compares the current stack’s resource state with the state
known to exist in the actual cloud provider. Any such changes are adopted
nto the current stack. Note that if the program text isn’t updated
accordingly, subsequent updates may still appear to be out of sync with
respect to the cloud provider’s source of truth.

```bash
pulumi refresh
```

TROUBLESHOOTING
---------------

Find out the used state backend storage:

```bash
pulumi whoami -v
```

See [troubleshooting](https://www.pulumi.com/docs/support/troubleshooting/)


READ AND CHANGE YAML FILES
--------------------------

By example:

```go
package gocode

import (
	"github.com/pulumi/pulumi-kubernetes/sdk/v3/go/kubernetes/yaml"
	"github.com/pulumi/pulumi/sdk/v3/go/pulumi"
	"github.com/pulumi/pulumi/sdk/v3/go/pulumi/config"
)

func PGCluster(ctx *pulumi.Context, nameSpaceName string) error {

	transformations := []yaml.Transformation{
		// Make every service private to the cluster, i.e., turn all services into ClusterIP
		// instead of LoadBalancer.
		func(state map[string]interface{}, opts ...pulumi.ResourceOption) {
			if state["kind"] == "PostgresCluster" {
				spec := state["spec"].(map[string]interface{})
				// spec["type"] = "ClusterIP"
				backups := spec["backups"].(map[string]interface{})
				pgbackrest := backups["pgbackrest"].(map[string]interface{})
				repos := pgbackrest["repos"].([]interface{})

				repo01 := make(map[string]interface{})
				repo01["name"] = "repo1"

				s3 := make(map[string]interface{})
				s3["bucket"] = "bucket"
				s3["endpoint"] = "endpoint"
				s3["region"] = "region"

				repo01["s3"] = s3
				repos[0] = repo01
			}
		},
	}

	_, err := yaml.NewConfigFile(ctx, "pg-cluster", &yaml.ConfigFileArgs{
		File:            "yaml/pg-cluster/*.yaml",
		Transformations: transformations,
	})
	if err != nil {
		return err
	}
	return nil

}
```

CREATE KUBERNETES SECRETS
-------------------------

By example:

```go
package gocode

import (
	"github.com/pulumi/pulumi-kubernetes/sdk/v3/go/kubernetes/yaml"
	core "github.com/pulumi/pulumi-kubernetes/sdk/v4/go/kubernetes/core/v1"
	meta "github.com/pulumi/pulumi-kubernetes/sdk/v4/go/kubernetes/meta/v1"
	"github.com/pulumi/pulumi/sdk/v3/go/pulumi"
	"github.com/pulumi/pulumi/sdk/v3/go/pulumi/config"
)

func PGCluster(ctx *pulumi.Context, nameSpaceName string) error {
	cfg := config.New(ctx, "")
	postgresS3BackupSecret := cfg.RequireSecret("postgres_s3_backup_secret")

	_, err := core.NewSecret(ctx, "postgres-s3-backup-secret", &core.SecretArgs{
		Metadata: &meta.ObjectMetaArgs{
			Name:      pulumi.String("postgres-s3-backup-secret"),
			Namespace: pulumi.String(nameSpaceName),
		},
		Type: pulumi.String("Opaque"),
		StringData: pulumi.StringMap{
			"s3.conf": postgresS3BackupSecret,
		},
	})
	if err != nil {
		return err
	}
}
```