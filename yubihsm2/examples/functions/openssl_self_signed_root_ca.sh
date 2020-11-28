
openssl_self_signed_root_ca () {

  printf "####################################### \n"
  printf "Crwate self signed root_ca: \n"
  printf "####################################### \n"


  printf "#-------------------------------------# \n"
  printf "...With key format variation: ${TEST_SLOT}:${TEST_SIGN_KEY}\n"
  printf "#-------------------------------------# \n"

  openssl req                                                                 \
    -new                                                                      \
    -x509                                                                     \
    -days 9125                                                                \
    -nodes                                                                    \
    -config ./openssl.cnf                                                     \
    -extensions v3_ca                                                         \
    -engine pkcs11                                                            \
    -key "${TEST_SLOT}:${TEST_SIGN_KEY}"                                      \
    -keyform engine                                                           \
    -out ./hsm-root-ca-01.dum.my.crt.pem

  printf "#-------------------------------------# \n"
  printf "...With key format variation: ${TEST_SLOT}:000${TEST_SIGN_KEY}\n"
  printf "#-------------------------------------# \n"

  openssl req                                                                 \
    -new                                                                      \
    -x509                                                                     \
    -days 9125                                                                \
    -nodes                                                                    \
    -config ./openssl.cnf                                                     \
    -extensions v3_ca                                                         \
    -engine pkcs11                                                            \
    -key "${TEST_SLOT}:000${TEST_SIGN_KEY}"                                   \
    -keyform engine                                                           \
    -out ./hsm-root-ca-01-v2.dum.my.crt.pem

  printf "#-------------------------------------# \n"
  printf "...With key format variation: slot_${TEST_SLOT}-id_${TEST_SIGN_KEY}\n"
  printf "#-------------------------------------# \n"

  openssl req                                                                 \
    -new                                                                      \
    -x509                                                                     \
    -days 9125                                                                \
    -nodes                                                                    \
    -config ./openssl.cnf                                                     \
    -extensions v3_ca                                                         \
    -engine pkcs11                                                            \
    -key "slot_${TEST_SLOT}-id_${TEST_SIGN_KEY}"                              \
    -keyform engine                                                           \
    -out ./hsm-root-ca-01-v3.dum.my.crt.pem

}