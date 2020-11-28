
init_vars_and_dirs () {

  printf "####################################### \n"
  printf "Init varables and directories: \n"
  printf "####################################### \n"

  export YUBIHSM_PKCS11_CONF=./yubihsm_pkcs11.conf
  export YUBIHSM_PKCS11_DBG=true
  export TEST_SLOT=0
  export TEST_FACTORY_KEY=1
  export TEST_FACTORY_PW=password
  export TEST_AUTH_KEY=2
  export TEST_AUTH_PW=password2
  export TEST_ROOT_CA_KEY=0004
  export TEST_ISSUE_CA_KEY=0005
  export DEMO_TMP_DIR=./tmp

  mkdir -p ${DEMO_TMP_DIR}
  echo 'connector = http://127.0.0.1:12345' > ${YUBIHSM_PKCS11_CONF}
  echo 'debug' >>  ${YUBIHSM_PKCS11_CONF}
  echo 'dinout' >>  ${YUBIHSM_PKCS11_CONF}
  echo 'libdebug' >>  ${YUBIHSM_PKCS11_CONF}
  echo "debug-file = ${DEMO_TMP_DIR}/debug_out" >>  ${YUBIHSM_PKCS11_CONF}

}