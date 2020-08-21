Sign git commits
================




Create key
----------

```bash
[or@augsburg02 play_pki_ca_with_ansible]$ gpg --default-new-key-algo rsa4096 --gen-key
gpg (GnuPG) 2.2.20; Copyright (C) 2020 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Note: Use "gpg --full-generate-key" for a full featured key generation dialog.

GnuPG needs to construct a user ID to identify your key.

Real name: Olaf Radicke
Email address: Augsburg
Not a valid email address
Email address: briefksten@olaf-radicke.de
You selected this USER-ID:
    "jane doe <jane.doe@dum.my>"

Change (N)ame, (E)mail, or (O)kay/(Q)uit? o
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
gpg: key 5275AF235D317DFD marked as ultimately trusted
gpg: directory '/home/jd/.gnupg/openpgp-revocs.d' created
gpg: revocation certificate stored as '/home/jd/.gnupg/openpgp-revocs.d/35822C4A7868945A683DF7B75275AF235D317DFD.rev'
public and secret key created and signed.

Note that this key cannot be used for encryption.  You may want to use
the command "--edit-key" to generate a subkey for this purpose.
pub   rsa4096 2020-08-09 [SC] [expires: 2022-08-09]
      35822C4A7868945A683DF7B75275AF235D317DFD
uid                      jane doe <jane.doe@dum.my>

```

List keys
---------

```bash
[or@augsburg02 play_pki_ca_with_ansible]$ gpg --list-secret-keys --keyid-format LONG
/home/or/.gnupg/pubring.kbx
---------------------------
sec   rsa4096/5275AF235D317DFD 2020-08-09 [SC] [expires: 2022-08-09]
      35822C4A7868945A683DF7B75275AF235D317DFD
uid                 [ultimate] Olaf Radicke <briefksten@olaf-radicke.de>
```

Add key
-------

```bash
[or@augsburg02 play_pki_ca_with_ansible]$ git config user.signingkey 35822C4A7868945A683DF7B75275AF235D317DFD
```

Sign a tag
----------

```bash
git tag -s -m 'This is sign.' sign_tag_01
```

Check tag sign
--------------

```bash
[or@augsburg02 play_pki_ca_with_ansible]$ git verify-tag  test-sign
gpg: Signature made Sun 09 Aug 2020 10:37:09 AM CEST
gpg:                using RSA key 35822C4A7868945A683DF7B75275AF235D317DFD
gpg: Good signature from "Olaf Radicke <briefksten@olaf-radicke.de>" [ultimate]
```

```bash
[radickeo@localhost play_pki_ca_with_ansible]$ git verify-tag --raw sign_tag_01
[GNUPG:] NEWSIG
[GNUPG:] KEY_CONSIDERED 29DE3428DC44096DF082401C215159DD89DB0174 0
[GNUPG:] SIG_ID dHfSwlw2SnO0tVbHSxjtxatVRII 2020-08-10 1597078079
[GNUPG:] KEY_CONSIDERED 29DE3428DC44096DF082401C215159DD89DB0174 0
[GNUPG:] GOODSIG 215159DD89DB0174 john doe <john.doe@dum.m>
[GNUPG:] VALIDSIG 29DE3428DC44096DF082401C215159DD89DB0174 2020-08-10 1597078079 0 4 0 1 8 00 29DE3428DC44096DF082401C215159DD89DB0174
[GNUPG:] KEY_CONSIDERED 29DE3428DC44096DF082401C215159DD89DB0174 0
[GNUPG:] TRUST_ULTIMATE 0 pgp
[GNUPG:] VERIFICATION_COMPLIANCE_MODE 23
```

```bash
[radickeo@localhost play_pki_ca_with_ansible]$ git tag -v  sign_tag_01
object d282a894a2add515d58607c496d478c61b9caf71
type commit
tag sign_tag_01
tagger Olaf Radicke <briefkasten@olaf-radicke.de> 1597078079 +0200

This is sign.
gpg: Signature made Mon 10 Aug 2020 06:47:59 PM CEST
gpg:                using RSA key 29DE3428DC44096DF082401C215159DD89DB0174
gpg: Good signature from "john doe <john.doe@dum.m>" [ultimate]
```

Check commit sign
-----------------

```bash
git -v verify-commit HEAD
```

Links
-----

* [gpg_whitelist](https://docs.ansible.com/ansible/latest/modules/git_module.html)
* [git-verify-commit](https://git-scm.com/docs/git-verify-commit)
* [git show  test-sign](https://developers.yubico.com/PGP/Git_signing.html)
