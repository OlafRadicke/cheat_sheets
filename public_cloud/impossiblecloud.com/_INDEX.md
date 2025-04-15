impossiblecloud.com
===================

- [impossiblecloud.com](#impossiblecloudcom)
	- [EXTERNAL DOKUMENTATION](#external-dokumentation)
	- [WEB CONSOLE](#web-console)
	- [END POINTS](#end-points)
	- [TOOLING](#tooling)
	- [EXAMPLES](#examples)
		- [Pulumi backend](#pulumi-backend)
		- [s3cmd](#s3cmd)
	- [CONNECTION BETWEEN BUCKETS AND KEYS](#connection-between-buckets-and-keys)



EXTERNAL DOKUMENTATION
----------------------

- [impossible cloud help](https://docs.impossiblecloud.com/impossible-cloud-help/)

WEB CONSOLE
-----------

The web console of [console.impossiblecloud.com/](https://console.impossiblecloud.com/)

Attanchon! All regions has his own web console:
- [us-west-1](https://console.impossiblecloud.com/)
- [eu-central-1](https://console.eu.impossiblecloud.com/)
- [eu-central-2](https://console.eu-2.impossiblecloud.com/)

END POINTS
----------

- `https://eu-central-2.storage.impossibleapi.net`

[other end points](https://docs.impossiblecloud.com/impossible-cloud-help/impossible-cloud-storage-guide/storage-console-urls-and-api-endpoints)

TOOLING
-------


- [S3Drive](https://s3drive.app/) is an easy to use client for S3.


EXAMPLES
--------

### Pulumi backend

```bash
pulumi login 's3://pulumi?region=us-west-1&endpoint=us-west-1.storage.impossibleapi.net'
```

### s3cmd

Pre step:

```bash
s3cmd --configure
```

...and answer the question. After here enter:

```bash
$ s3cmd ls eu-central-2.storage.impossibleapi.net
```

with bucket name

```bash
$ s3cmd ls vault-server-01.eu-central-2.storage.impossibleapi.net
```

```bash
$ s3cmd ls vault-server-02.eu-west-1.storage.impossibleapi.net
```

[external docu](https://s3tools.org/usage)

CONNECTION BETWEEN BUCKETS AND KEYS
-----------------------------------


First of all, you have two different kind of users: a root user, which is
automatically created with the storage account, and an IAM user (also known
as a sub-user).

If you create access key pair under the root user, those keys have no
limitations and can control all the buckets.

To limit an access to one or a few buckets, please do the following:

1. [Create a bucket](https://docs.impossiblecloud.com/impossible-cloud-help/impossible-cloud-storage-guide/buckets-and-objects/creating-a-bucket)
2. [Create a policy](https://docs.impossiblecloud.com/impossible-cloud-help/security/identity-access-management-iam/managing-policies) for that bucket including the permissions you need. You can use multiple buckets within the same policy with the same or different access permissions.
3. [Create an IAM user](https://docs.impossiblecloud.com/impossible-cloud-help/security/identity-access-management-iam/managing-users)
4. [Create a group](https://docs.impossiblecloud.com/impossible-cloud-help/security/identity-access-management-iam/managing-groups). Assign the user and the policy created on the steps above by selecting the checkboxes. Click "Add".
5. Open the "Users" tab on the left, click on your new IAM user.
6. Click "Access Keys" under that user and create a new access key.

Result: the access key pair belong to that user and will have permissions
described in the policy to the buckets which also described in the policy.