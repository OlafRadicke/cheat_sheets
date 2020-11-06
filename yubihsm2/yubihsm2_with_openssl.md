YubiHSM2 with OpenSSL
=====================


Generate and verify digital signatures
--------------------------------------

```bash
openssl dgst -engine pkcs11 \
             -keyform engine \
             -sign "pkcs11:token=YubiHSM;id=%04%01;type=private" \
             -out t3200.pkcs1.sig \
             -sha384 t3200.dat
```



engine_pkcs11 and yubihsm_pkcs11
--------------------------------

Requirements:

* Fedora
  * 'opensc' to provide command 'pkcs11-tool'
  * openssl-pkcs11

Result of find commnd:

```
/usr/lib64/opensc-pkcs11.so
/usr/lib64/pkcs11/opensc-pkcs11.so
/usr/lib64/pkcs11/yubihsm_pkcs11.so
/usr/lib64/engines-1.1/libpkcs11.so
/usr/lib64/engines-1.1/pkcs11.so
```

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

Example files: See [/examples](/examples)


Documentatin und links
----------------------

* [OpenSSL with YubiHSM II.: Sign files](https://developers.yubico.com/YubiHSM2/Usage_Guides/OpenSSL_with_libp11.html)
* [OpenSSL with YubiHSM II.: pkcs11](https://developers.yubico.com/YubiHSM2/Usage_Guides/OpenSSL_with_pkcs11_engine.html)
* [OpenSC pkcs11-tool](https://developers.yubico.com/YubiHSM2/Usage_Guides/Using_OpenSC_pkcs11-tool.html)