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
[or@augsburg02 cheat_sheets]$ yubihsm-shell
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

Format: ```list objects <session number>```

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


Documentatin und links
----------------------

* [yubihsm-shell](https://developers.yubico.com/yubihsm-shell/yubihsm-shell.html)
* [Usage Guides](https://developers.yubico.com/YubiHSM2/Usage_Guides/)
* [YubiHSM quick start tutorial](https://developers.yubico.com/YubiHSM2/Usage_Guides/YubiHSM_quick_start_tutorial.html)