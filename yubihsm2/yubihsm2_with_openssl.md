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
openssl dgst -engine pkcs11 \
             -keyform engine \
             -sign "pkcs11:token=YubiHSM;id=%04%01;type=private" \
             -out t3200.pkcs1.sig \
             -sha384 t3200.dat
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


Example files
-------------

See: [/examples](/examples)


Documentatin und links
----------------------

* [OpenSSL with YubiHSM II.: Sign files](https://developers.yubico.com/YubiHSM2/Usage_Guides/OpenSSL_with_libp11.html)
* [OpenSSL with YubiHSM II.: pkcs11](https://developers.yubico.com/YubiHSM2/Usage_Guides/OpenSSL_with_pkcs11_engine.html)
* [OpenSC pkcs11-tool](https://developers.yubico.com/YubiHSM2/Usage_Guides/Using_OpenSC_pkcs11-tool.html)