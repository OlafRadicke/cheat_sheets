PULUMI
======

Install Pulumi
--------------

See: [https://www.pulumi.com/docs/install/](https://www.pulumi.com/docs/install/)

```bash
curl -fsSL https://get.pulumi.com | sh
```


Google provider as backend
--------------------------

1. Install [CLI](https://cloud.google.com/docs/authentication/provide-credentials-adc?hl=de#how-to)
2. Create Google Bucket
3. Login in Google ```gcloud auth application-default login```
4. Pulumi login: ```pulumi login gs://h9jedp3jch53psor```


Create new Pulumi project
-------------------------

To use the passphrase secrets provider with the pulumi.com backend, use:

```bash
pulumi new kubernetes-go \
	--description="k3s IaC" \
	--name="baltic-sea" \
	--secrets-provider=passphrase \
	--stack="prod"
```

Alternative for other templates:

- "kubernetes-typescript"
- "kubernetes-javascript"
- "kubernetes-python"
- "kubernetes-yaml"


See more: [www.pulumi.com/docs](https://www.pulumi.com/docs/cli/commands/pulumi_new/)

Deploy stack
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


yaml support
------------

See: [pulumi.com/docs](https://www.pulumi.com/docs/using-pulumi/adopting-pulumi/migrating-to-pulumi/from-kubernetes/)

Helm Chart support
------------------

See: [pulumi.com/registry](https://www.pulumi.com/registry/packages/kubernetes/api-docs/helm/v3/chart/)

Remove stack
------------

```bash
PULUMI_CONFIG_PASSPHRASE_FILE=${HOME}/.ssh/pulumi-passwd \
pulumi destroy
```

pulumi watch
------------


This command watches the working directory or specified paths for the current project and updates the active stack whenever the project changes. In parallel, logs are collected for all resources in the stack and displayed along with update progress.


troubleshooting
---------------

Find out the used state backend storage:

```bash
pulumi whoami -v
```

See [troubleshooting](https://www.pulumi.com/docs/support/troubleshooting/)