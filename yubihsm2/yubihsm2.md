YubiHSM2
========

Install bash tools
------------------

*Under Fedora enter:*

```bash
sudo dnf install -y yubihsm-shell
```

Init HSM
--------


***Note** that the YubiHSM 2 ships with a default Authentication Key with a well-known password. It is imperative to remove it prior to production deployment.*

To physically reset the YubiHSM 2 insert the device while holding the touch sensor for 10 seconds.

Concepts
--------

A **Session** is not a property of a specific Object, but rather it is used to describe a logical connection between an application and a device. Sessions are end-to-end encrypted and authenticated using Session Keys. Those keys are derived from long-lived, pre-shared Authentication Key Objects as part of the sessions authentication process. [See more: *session*](https://developers.yubico.com/YubiHSM2/Concepts/Session.html)

A **Domain** is a logical partition and can be conceptually mapped to a container. In a YubiHSM 2 there are 16 independent Domains and an Object can belong to one or more.

Any persistently-stored and self-contained piece of information present in a YubiHSM 2, is an **Object**. [See mor: *objects*](https://developers.yubico.com/YubiHSM2/Concepts/Object.html)

A **Capability** is an attribute that can be given to an Object allowing specific operations to be performed on or with it. Commands like digital signature generation and data decryption require (and check) for a predetermined set of Capabilities to be present on an Object. [See more: *Capability*](https://developers.yubico.com/YubiHSM2/Concepts/Capability.html)

A **Label** is a sequence of bytes that can be used to add a mnemonic reference to Objects.

Main commands - interactiv
--------------------------

#### Start the connector

Enter (with privileged escalation)

```bash
sudo yubihsm-connector -d
```

And checkout status under [http://127.0.0.1:12345/connector/status](http://127.0.0.1:12345/connector/status)

Oben the yubihsm-shell (without privileged escalation)

```bash
[or@aug]$ yubihsm-shell
Using default connector URL: http://127.0.0.1:12345
```

#### Quit shell

Enter ```q```

#### Open a session

Formart: ```session open <object number> <password>```

```bash
yubihsm> session open 1 password
Created session 0
```

That's is the preseted factory object wihte factory password.

#### Close session

Formart ```session close <session number>```

#### list objects

Format (session): ```list objects <session number>```

#### Generate a Key for Signing

Format ```generate <type> <session id> <objekt id> <label> <domains> <capabilities> <algorithm>```

```bash
yubihsm> generate asymmetric 1 100 label_ecdsa_sign 1,2,3 exportable-under-wrap,sign-ecdsa ecp256
```

#### Sign file

```bash
yubihsm> sign ecdsa 1 100 ecdsa-sha256 data.txt
```

#### Export public key

```bash
get pubkey 1 100 /tmp/asymmetric_key.pub
```

#### Delete object

Format: ```delete <session id> <object id> <oject type>```

```bash
yubihsm> list objects 1
Found 2 object(s)
id: 0x0001, type: authentication-key, sequence: 0
id: 0x0063, type: asymmetric-key, sequence: 0

yubihsm> delete 1 0x0063 asymmetric-key

yubihsm> list objects 1
Found 1 object(s)
id: 0x0001, type: authentication-key, sequence: 0
```

Main commands - non interactiv
------------------------------

For geting help enter: ```yubihsm-shell --help```
or enter: ```man yubihsm-shell```

#### Command parameters

* *-a* Action
* *-d* Domain
* *-t* Object type
* *-A* Operation algorithm
* *-p* Password
* *-i* Opject ID
* *--authkey* The key that is using for authentication
* *-c* Capabilities for an object

#### List objects

```bash
yubihsm-shell -a list-objects -d 0 -t any -A any  -p password
```

```bash
[or@aug]$ yubihsm-shell -a list-objects \
                        -d 0 \
                        -t any \
                        -A any \
                        -p password2 \
                        --authkey="0x9d17"

Using default connector URL: http://127.0.0.1:12345
Session keepalive set up to run every 15 seconds
Created session 0
Found 3 object(s)
id: 0x0001, type: authentication-key, sequence: 0
id: 0x0063, type: asymmetric-key, sequence: 1
id: 0x9d17, type: authentication-key, sequence: 0
```

#### Get object infos

```bash
[or@aug]$ yubihsm-shell -a get-object-info \
                        -i 0x9893 \
                        -t authentication-key \
                        -A any \
                        -p password4 \
                        --authkey=0x9893

Using default connector URL: http://127.0.0.1:12345
Session keepalive set up to run every 15 seconds
Created session 0
id: 0x9893, \
type: authentication-key, \
algorithm: aes128-yubico-authentication, \
label: "Audit auth key 4", \
length: 40, \
domains: 1:2:3:4:5:6:7:8:9:10:11:12:13:14:15:16, \
sequence: 0, \
origin: imported, \
capabilities: change-authentication-key:create-otp-aead:[...]]: 
```


#### Create an Authentication Key for Auditing

```bash
[or@aug]$ yubihsm-shell -a put-authentication-key \
                        -i 0x0002 \
                        -l "Audit auth key" \
                        -c "all" \
                        -t "all" \
                        --authkey=0x0003 \
                        -p "password3" \
                        --new-password="password2"

Using default connector URL: http://127.0.0.1:12345
Session keepalive set up to run every 15 seconds
Created session 0
Stored Authentication key 0x9d17
```

#### Create asymmetric key (for CA)

```bash
[or@aug]$ yubihsm-shell -a put-asymmetric-key \
                        -i 0x0006 \
                        -d 0 \
                        -l "CA key" \
                        -c "all" \
                        -A "sign-pkcs" \
                        -t "256" \
                        --authkey=0x0003 \
                        -p "password3"
```


#### Delete object

```bash
[or@aug]$ yubihsm-shell -a delete-object \
                        -d 1 \
                        -i "0x9d17" \
                        -t "authentication-key" \
                        -p "password" 
```

yubihsm> delete 1 0x0063 asymmetric-key


#### Change authentication-key

change-authentication-key

Remove factory key
------------------

```bash
[or@aug]$ yubihsm-shell -a list-objects \
                        -d 0 \
                        -t any \
                        -A any \
                        -p password

Using default connector URL: http://127.0.0.1:12345
Session keepalive set up to run every 15 seconds
Created session 1
Found 2 object(s)
id: 0x0001, type: authentication-key, sequence: 0
id: 0x0063, type: asymmetric-key, sequence: 1

[or@aug]$ yubihsm-shell -a put-authentication-key \
                        -i 0x0002 \
                        -l "Audit auth key" \
                        -c "all" \
                        -t "all" \
                        --delegated="all" \
                        --new-password="password2" \
                        -p "password"


Using default connector URL: http://127.0.0.1:12345
Session keepalive set up to run every 15 seconds
Created session 0
Stored Authentication key 0x0002

[or@aug]$ yubihsm-shell -a list-objects \
                        -d 0 \
                        -t any \
                        -A any \
                        -p password

Using default connector URL: http://127.0.0.1:12345
Session keepalive set up to run every 15 seconds
Created session 0
Found 3 object(s)
id: 0x0001, type: authentication-key, sequence: 0
id: 0x0002, type: authentication-key, sequence: 0


[or@aug]$ yubihsm-shell -a delete-object \
                        -i "0x0001" \
                        -t "authentication-key" \
                        --authkey="0x0002"  \
                        -p "password2" 

Using default connector URL: http://127.0.0.1:12345
Session keepalive set up to run every 15 seconds
Created session 0


[or@aug]$ yubihsm-shell -a put-authentication-key 
                        -i "0x0003" \
                        -c 'all' \
                        -t "all" \
                        --delegated="all" \
                        -l "Audit auth key 3" \
                        --new-password="password3" \
                        --authkey="0x0002"  \
                        -p "password2"

Using default connector URL: http://127.0.0.1:12345
Session keepalive set up to run every 15 seconds
Created session 1
Stored Authentication key 0x0003

[or@aug]$ yubihsm-shell -a get-object-info \
                        -i 0x0002 \
                        -t authentication-key \
                        -A any  \
                        -p password4 \
                        --authkey=0x9893

Using default connector URL: http://127.0.0.1:12345
Session keepalive set up to run every 15 seconds
Created session 0
id: 0x0003, type: authentication-key, algorithm: aes128-yubico-authentication, label: "Audit auth key", length: 40, domains: 1:2:3:4:5:6:7:8:9:10:11:12:13:14:15:16, sequence: 0, origin: imported, capabilities: change-authentication-key:create-otp-aead:decrypt-oaep:decrypt-otp:decrypt-pkcs:delete-asymmetric-key:delete-authentication-key:delete-hmac-key:delete-opaque:delete-otp-aead-key:delete-template:delete-wrap-key:derive-ecdh:export-wrapped:exportable-under-wrap:generate-asymmetric-key:generate-hmac-key:generate-otp-aead-key:generate-wrap-key:get-log-entries:get-opaque:get-option:get-pseudo-random:get-template:import-wrapped:put-asymmetric-key:put-authentication-key:put-mac-key:put-opaque:put-otp-aead-key:put-template:put-wrap-key:randomize-otp-aead:reset-device:rewrap-from-otp-aead-key:rewrap-to-otp-aead-key:set-option:sign-attestation-certificate:sign-ecdsa:sign-eddsa:sign-hmac:sign-pkcs:sign-pss:sign-ssh-certificate:unwrap-data:verify-hmac:wrap-data, delegated_capabilities: change-authentication-key:create-otp-aead:decrypt-oaep:decrypt-otp:decrypt-pkcs:delete-asymmetric-key:delete-authentication-key:delete-hmac-key:delete-opaque:delete-otp-aead-key:delete-template:delete-wrap-key:derive-ecdh:export-wrapped:exportable-under-wrap:generate-asymmetric-key:generate-hmac-key:generate-otp-aead-key:generate-wrap-key:get-log-entries:get-opaque:get-option:get-pseudo-random:get-template:import-wrapped:put-asymmetric-key:put-authentication-key:put-mac-key:put-opaque:put-otp-aead-key:put-template:put-wrap-key:randomize-otp-aead:reset-device:rewrap-from-otp-aead-key:rewrap-to-otp-aead-key:set-option:sign-attestation-certificate:sign-ecdsa:sign-eddsa:sign-hmac:sign-pkcs:sign-pss:sign-ssh-certificate:unwrap-data:verify-hmac:wrap-data

```


Documentatin und links
----------------------


* **[Cheat sheets of YubiHSM2 with OpenSSL](tools/yubihsm2_with_openssl.md)**
* Externel docs:
  * [yubihsm-shell](https://developers.yubico.com/yubihsm-shell/yubihsm-shell.html)
  * [Usage Guides](https://developers.yubico.com/YubiHSM2/Usage_Guides/)
  * [YubiHSM quick start tutorial](https://developers.yubico.com/YubiHSM2/Usage_Guides/YubiHSM_quick_start_tutorial.html)