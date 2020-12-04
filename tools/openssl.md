OpenSSL
=======

Check Certificate Signing Request (CSR)
---------------------------------------

```bash
$ openssl req \
    -noout \
    -text \
    -in jane_doe.csr
```

View key file
-------------

```bash
$ openssl \
    -noout \
    -text \
    -passin "pass:this-is-my-password" \
    -in my-key-file.pem
```

Check Certificate
-----------------

```bash
$ openssl x509 \
    -noout \
    -text \
    -in jane_doe.crt
```

check cert bundle
-----------------

```bash
openssl crl2pkcs7 -nocrl -certfile dummy.bundle.pem | openssl pkcs7 -print_certs -text -noout
```

Verify Certificate Chain
------------------------

After openssl create certificate chain, to verify certificate chain use below command:

```bash
openssl verify -CAfile certs/cacert.pem intermediate/certs/ca-chain-bundle.cert.pem

intermediate/certs/ca-chain-bundle.cert.pem: OK
```

To verify certificate chain for online:

```bash
openssl s_client -quiet -connect google.com:443
```

Links
-----
* [OpenSSL (de)](https://wiki.magenbrot.net/linux/kryptographie/ssl/openssl-zertifikate)
* [Alternatives cfssl](https://github.com/cloudflare/cfssl)