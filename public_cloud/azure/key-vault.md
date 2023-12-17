key-vault
=========


Set secret
----------

```
az keyvault secret set \
  --vault-name "olafradickekeystore" \
  --name "ExamplePassword" \
  --value "hVFkk965BuUv"
```

Get value
---------


```
az keyvault secret show \
  --vault-name "olafradickekeystore" \
  --name "ExamplePassword" \
  --query "value"
```