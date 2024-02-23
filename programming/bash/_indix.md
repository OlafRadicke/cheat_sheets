BASH
====

BASICS
------

```bash
#!/usr/bin/env bash

set -x
set -u
set -e
```

SET DEFAULT VALUES
------------------

```bash
if [ -z ${MY_ENV_VAR+x} ]
then
	echo "var is unset"
	MY_ENV_VAR="my default"
else
	echo "var is set to '$MY_ENV_VAR'"
fi
```
