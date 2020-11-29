

openssl_create_intermediate_ca_csr () {

  printf "####################################### \n"
  printf "Kreate CSR for issue ca \n"
  printf "/functions/openssl_create_intermediate_ca_csr.sh \n"
  printf "####################################### \n"

  openssl req                                                                 \
    -new                                                                      \
    -sha256                                                                   \
    -nodes                                                                    \
    -config ${DEMO_CONFIG_DIR}/issue_ca/openssl.cnf                           \
    -engine pkcs11                                                            \
    -key ${TEST_SLOT}:${TEST_ISSUE_CA_KEY}                                    \
    -keyform engine                                                           \
    -out ${DEMO_TMP_DIR}/issue_ca.csr.pem


}