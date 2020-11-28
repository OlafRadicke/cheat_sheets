Example bash script
===================

The bash script demonstrates the bash interface of YubiHSM2.

Requirement
-----------

To run the script the following preparations must be made:

- Install:
 - OpenSSL
 - YubiHSM-Shell
 - YubiHSM OpenSSL engine
- An YubiHSM2 in facktory reset state


Warning
-------

***...do not use the script for a productive HSM!***

Run the script
--------------

Enter:

```bash
sudo ./demo_script.sh
```

With more output enter:

```bash
sudo -e -x demo_script.sh
```
