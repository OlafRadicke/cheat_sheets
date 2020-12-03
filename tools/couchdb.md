CouchDB
=======


Web console
-----------

```bash
https://dum.mym:5984/_utils/
```


Attaching files
---------------

```bash
$ curl  \
    -u "my_admin:my_password"  \
    -X PUT   \
   "http://pki-couchdb.dum.my:5984/pki/root-ca/ca_priv_key.pem?rev=277-d915cc08d32cd7b986a68e833d04b7ff\"  \
   -H "Content-Type: 'application/octet-stream'"  \
   --data-binary  \
   @/pki_ca_run_env/private/root-ca.key.pem
```

Download of files
-----------------

```bash
$ curl \
    -u "my_admin:my_password"  \
    -X GET  \
    "http://pki-couchdb.dum.my:5984/pki/root-ca/ca_priv_key.pem"  \
    > /pki_ca_run_env/private/root-ca.key.pem
```