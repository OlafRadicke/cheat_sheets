cfssl
=====

[Project docu](https://github.com/cloudflare/cfssl)


Installation
------------

```bash
sudo dnf install -y golang-github-cloudflare-cfssl
```

CSR
---

Json example

Create root ca an server certificat.

```bash
cfssl print-defaults config > ca-config.json
cfssl print-defaults csr > ca-csr.json
cfssl gencert -initca ca-csr.json | cfssljson -bare ca -
cfssl print-defaults csr > server.json
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=www server.json | cfssljson -bare server
```

Create client certifikat

```bash
cfssl print-defaults csr > client.json
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=client client.json | cfssljson -bare client
```
