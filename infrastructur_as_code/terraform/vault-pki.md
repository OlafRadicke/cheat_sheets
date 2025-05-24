VAULT PKI
=========

Das Terraform-Vault-Modul hat mehere schwächen:

- API-Doku ist unvollständig / unverständlich
- Kaum brauchbare beispiele
- Terraform kan die erstellten Ressourcen (Issuer) nicht zuverlässig abräumen, wenn die Terraform Ressourcen im code entfernt werden.
- Die Bezeichner der Terraform-Ressourcen sind verwirrend benannt. So ist z.B. ein "backend" Pfad und "issuer_ref" eine ID.
- Man bekommt keinen Fehler und die Ressouren wurden trozdem nicht erstellt.
- Die Laufzeit einstellung der Zertifikate (ttl) zeigt keine Auswirkung.
- Die CA Chain wird nicht korrekt erstellt für sub-CAs
- CAs bekommen generisch-kryptische Namen. Das lässt sich nur für die Root-CA abstellen.