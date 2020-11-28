

create_ca_keys () {

  printf "####################################### \n"
  printf "Kreate keys for ca: ${1} ${2} \n"
  printf "####################################### \n"

  yubihsm-shell                                                               \
    --action=generate-asymmetric-key                                          \
    --object-id=${1}                                                          \
    --label="${2}"                                                            \
    --algorithm="rsa2048"                                                     \
    --capabilities=sign-pkcs,sign-pss,sign-ecdsa,sign-eddsa,sign-ssh-certificate \
    --authkey="${TEST_AUTH_KEY}"                                              \
    --password="${TEST_AUTH_PW}"

}