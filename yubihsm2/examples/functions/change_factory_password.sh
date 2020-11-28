

change_factory_password () {

  printf "####################################### \n"
  printf "Change factory password of YubiHSM2: \n"
  printf "####################################### \n"


  printf "#-------------------------------------# \n"
  printf "...Create new authentication-key: ${TEST_AUTH_KEY}\n"
  printf "#-------------------------------------# \n"

  yubihsm-shell                                                               \
    --action=put-authentication-key                                           \
    --object-id=${TEST_AUTH_KEY}                                              \
    --label="Audit auth key"                                                  \
    --capabilities="all"                                                      \
    --object-type="all"                                                       \
    --delegated="all"                                                         \
    --new-password="${TEST_AUTH_PW}"                                          \
    --authkey="${TEST_FACTORY_KEY}"                                           \
    --password="${TEST_FACTORY_PW}"

  printf "#-------------------------------------# \n"
  printf "...Delet the factory key: ${TEST_FACTORY_KEY}\n"
  printf "#-------------------------------------# \n"

  yubihsm-shell                                                               \
    --action=delete-object                                                    \
    --object-id="${TEST_FACTORY_KEY}"                                         \
    --object-type="authentication-key"                                        \
    --authkey="${TEST_AUTH_KEY}"                                              \
    --password="${TEST_AUTH_PW}"

}