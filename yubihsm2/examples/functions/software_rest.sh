

software_rest() {

  printf "####################################### \n"
  printf "Sofware reset of YubiHSM2: \n"
  printf "####################################### \n"

  yubihsm-shell                                                               \
    --action=reset                                                            \
    --domains=${TEST_SLOT}                                                    \
    --authkey=${TEST_AUTH_KEY}                                                \
    --password="${TEST_AUTH_PW}"

}