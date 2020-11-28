#!/bin/bash
clear

# set -e

source ./functions/change_factory_password.sh
source ./functions/create_ca_key.sh
source ./functions/init_vars_and_dirs.sh
source ./functions/list_objects.sh
source ./functions/openssl_self_signed_root_ca.sh
source ./functions/software_rest.sh

init_vars_and_dirs
list_objects ${TEST_FACTORY_KEY} ${TEST_FACTORY_PW}
change_factory_password
list_objects ${TEST_AUTH_KEY} ${TEST_AUTH_PW}
create_ca_keys ${TEST_ROOT_CA_KEY} "root_ca_sign_key"
list_objects ${TEST_AUTH_KEY} ${TEST_AUTH_PW}
create_ca_keys ${TEST_ISSUE_CA_KEY} "issue_ca_sign_key"
list_objects ${TEST_AUTH_KEY} ${TEST_AUTH_PW}
software_rest
sleep 2
list_objects ${TEST_FACTORY_KEY} ${TEST_FACTORY_PW}

# openssl_self_signed_root_ca








