GOOGLE CLOUD
============


LOCAL INSTALL
-------------

see: [gcloud-CLI installieren](https://cloud.google.com/sdk/docs/install?hl=de)


LOGIN
-----

### LOGIN

```bash
gcloud auth login
```

or

```bash
gcloud auth application-default set-quota-project XYZ-project
gcloud config set project XYX-project
gcloud auth application-default login
```

### LIST

```bash
gcloud auth list
```

### SET QUOTA

```bash
gcloud auth application-default set-quota-project pulumi-prod
```

ORGANISATION
------------

```bash
gcloud organizations list
```

BILLING
-------

```bash
gcloud billing projects list \
	--billing-account=[ACCOUNT_ID]
```

PROJECT
-------

### LIST

```bash
gcloud projects list
```

### CREATE

```
gcloud projects create \
	--organization=
[project]
```


### SET PROJECT

```bash
gcloud config set project [project]
```

### GET


```bash
gcloud config get project
```

### QUOTA

```
gcloud auth application-default set-quota-project [project]
```

STORAGE
-------

### LIST BUCKETS

```bash
gcloud storage buckets list
```

### CREATE

```bash
gcloud storage buckets create \
	--location=europe-west3 \
	--no-public-access-prevention \
	--default-storage-class=NEARLINE \
	gs://pulumi-prod-atlantic-ocean
```