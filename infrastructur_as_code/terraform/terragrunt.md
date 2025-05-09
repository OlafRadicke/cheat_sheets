TERRAGRUNT
==========

Using env variables
-------------------

Enter this lines in the terragrunt.hcl file:

```
inputs = {
  vault_token = get_env("VAULT_TOKEN", "")
}
```

This read te env variable `VAULT_TOKEN` and passed to the variable vault_token.