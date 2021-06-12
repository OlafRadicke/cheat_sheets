YubiHSM2 with OpenSSL
=====================

Requirements
------------

engine_pkcs11 and yubihsm_pkcs11

* Fedora
  * 'opensc' to provide command 'pkcs11-tool'
  * openssl-pkcs11
  * yubihsm-shell

Lib pathes:


```
/usr/lib64/opensc-pkcs11.so
/usr/lib64/pkcs11/opensc-pkcs11.so
/usr/lib64/pkcs11/yubihsm_pkcs11.so
/usr/lib64/engines-1.1/libpkcs11.so
/usr/lib64/engines-1.1/pkcs11.so
```


Generate and verify digital signatures
--------------------------------------

### OpenSSL ###

```bash
export YUBIHSM_PKCS11_CONF=./yubihsm_pkcs11.conf
AUTH_KEY=1
AUTH_PASSWORD=password
TEST_SIGN_KEY=0004

echo 'connector = http://127.0.0.1:12345' > ${YUBIHSM_PKCS11_CONF}

yubihsm-shell                                                                 \
--action=list-objects                                                         \
 --domains=0                                                                  \
 --object-type=any                                                            \
 --algorithm=any                                                              \
 --authkey="${AUTH_KEY}"                                                 \
--password="${AUTH_PASSWORD}"                                                  \

yubihsm-shell                                                                 \
  --action=generate-asymmetric-key                                            \
  --object-id=${TEST_SIGN_KEY}                                                \
  --label="root_ca_sign_key"                                                  \
  --algorithm="rsa3072"                                                       \
  --capabilities=sign-pkcs,sign-pss,sign-ecdsa,sign-eddsa,sign-ssh-certificate \
  --authkey=${AUTH_KEY}                                                  \
  --password="${AUTH_PASSWORD}"

openssl req                                                                   \
  -new                                                                        \
  -sha256                                                                     \
  -nodes                                                                      \
  -config ./openssl.cnf                                                       \
  -extensions v3_ca                                                           \
  -engine pkcs11                                                              \
  -key 0:${TEST_SIGN_KEY}                                                     \
  -keyform engine                                                             \
  -out ./hsm-root-ca-01.dum.my.csr.pem


openssl req                                                                   \
  -new                                                                        \
  -x509                                                                       \
  -days 9125                                                                  \
  -nodes                                                                      \
  -config ./openssl.cnf                                                       \
  -extensions v3_ca                                                           \
  -engine pkcs11                                                              \
  -key "${AUTH_KEY}:${TEST_SIGN_KEY}"                                    \
  -keyform engine                                                             \
  -out ./hsm-root-ca-01.dum.my.crt.pem

openssl req                                                                   \
  -new                                                                        \
  -x509                                                                       \
  -days 9125                                                                  \
  -nodes                                                                      \
  -config ./openssl.cnf                                                       \
  -extensions v3_ca                                                           \
  -engine pkcs11                                                              \
  -key "000${AUTH_KEY}:${TEST_SIGN_KEY}"                                 \
  -keyform engine                                                             \
  -out ./hsm-root-ca-01.dum.my.crt.pem

openssl req                                                                   \
  -new                                                                        \
  -x509                                                                       \
  -days 9125                                                                  \
  -nodes                                                                      \
  -config ./openssl.cnf                                                       \
  -extensions v3_ca                                                           \
  -engine pkcs11                                                              \
  -key "slot_0-id_${TEST_SIGN_KEY}"                                           \
  -keyform engine                                                             \
  -out ./hsm-root-ca-01.dum.my.crt.pem

yubihsm-shell                                                                 \
 --action=list-objects                                                        \
 --domains=0                                                                  \
 --object-type=any                                                            \
 --algorithm=any                                                              \
 --authkey="${AUTH_KEY}"                                                 \
 --password="${AUTH_PASSWORD}"
```

OpenSSL config:

```
HOME                        = .

openssl_conf                = default_modules

[default_modules]
engines                     = engine_section

[engine_section]
pkcs11                      = pkcs11_section

[pkcs11_section]
engine_id                   = pkcs11
MODULE_PATH                 = /usr/lib64/pkcs11/yubihsm_pkcs11.so
INIT_ARGS                   = connector=http://127.0.0.1:12345 debug
PIN                         = "0001password"
init                        = 0

[...]
```


### pkcs11-tool ###


Example:

```bash
pkcs11-tool --module /usr/lib64/pkcs11/yubihsm_pkcs11.so \
            --login \
            --pin 0001password \
            --keypairgen \
            --key-type rsa:2048 \
            --label "my_key" \
            --usage-sign
```

```bash
pkcs11-tool                                                                   \
  --module /usr/lib64/pkcs11/yubihsm_pkcs11.so                                \
  --keypairgen                                                                \
  --usage-sign                                                                \
  --label "root-ca-private-key"                                               \
  --key-type rsa:2048                                                         \
  --login                                                                     \
  --pin 0001password
```


Capability
----------

A selection:

- **name:** sign-pkcs
  - **Hex Mask:** 0x0000000000000020
  - **Applicable Objects:** authentication-key, asymmetric-key
  - **Description:** Compute signatures using RSA-PKCS1v1.5
- **name:** sign-pss
  - **Hex Mask:** 0x0000000000000040
  - **Applicable Objects:** authentication-key, asymmetric-key
  - **Description:** Compute digital signatures using using RSA-PSS
- **name:** sign-ecdsa
  - **Hex Mask:** 0x0000000000000080
  - **Applicable Objects:** authentication-key, asymmetric-key
  - **Description:** Compute digital signatures using ECDSA
- **name:** sign-eddsa
	- **Hex Mask:** 0x0000000000000100
	- **Applicable Objects:** authentication-key, asymmetric-key
	- **Description:** Compute digital signatures using EDDSA
- **name:** sign-ssh-certificate
	- **Hex Mask:** 0x0000000002000000
  - **Applicable Objects:** authentication-key, asymmetric-key
	- **Description:** Sign SSH certificates


Troubleshooting
---------------

Check HSM Service

```
# systemctl status yhconsrv
```

Find Logs:

```
[or@olafthink cheat_sheets]$ sudo journalctl -t  yubihsm-connector -f

-- Logs begin at Thu 2020-05-21 19:59:57 CEST. --
Nov 14 09:07:33 olafthink.localdomain yubihsm-connector[1719]: 2020/11/14 09:07:33 handle_events: error: libusb: interrupted [code -10]

```

Debugging mode:

```bash

export YUBIHSM_PKCS11_DBG=true
echo 'connector = http://127.0.0.1:12345' > ${YUBIHSM_PKCS11_CONF}
echo 'debug' >>  ${YUBIHSM_PKCS11_CONF}
echo 'dinout' >>  ${YUBIHSM_PKCS11_CONF}
echo 'libdebug' >>  ${YUBIHSM_PKCS11_CONF}
echo 'debug-file = ./debug_out' >>  ${YUBIHSM_PKCS11_CONF}

```


Example files
-------------

See: [/examples](/examples)


Documentatin und links
----------------------

* [OpenSSL with YubiHSM II.: Sign files](https://developers.yubico.com/YubiHSM2/Usage_Guides/OpenSSL_with_libp11.html)
* [OpenSSL with YubiHSM II.: pkcs11](https://developers.yubico.com/YubiHSM2/Usage_Guides/OpenSSL_with_pkcs11_engine.html)
* [OpenSC pkcs11-tool](https://developers.yubico.com/YubiHSM2/Usage_Guides/Using_OpenSC_pkcs11-tool.html)
* [Capability](https://developers.yubico.com/YubiHSM2/Concepts/Capability.html)
* [yubihsm with python](https://github.com/YubicoLabs/python-pkcs11tester/blob/master/pkcs11tester.py)
* [yubi on GitHub](https://github.com/Yubico)