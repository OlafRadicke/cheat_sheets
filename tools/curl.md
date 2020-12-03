curl
====


Attaching Files (CouchDB)
-------------------------

```bash
$ curl  \
  -u \"my_admin:my_password"  \
   -X PUT   \
   "http://pki-couchdb.dum.my:5984/pki/root-ca/ca_priv_key.pem?rev=277-d915cc08d32cd7b986a68e833d04b7ff\"  \
   -H "Content-Type: 'application/octet-stream'"  \
   --data-binary  \
   -d@/pki_ca_run_env/private/root-ca.key.pem
```