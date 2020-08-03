OpenSSL
=======

Check Certificate Signing Request (CSR)
---------------------------------------

```bash
openssl req -noout -text -in jane_doe.csr
```

Check Certificate
-----------------

```bash
openssl x509 -noout -text -in jane_doe.crt
```