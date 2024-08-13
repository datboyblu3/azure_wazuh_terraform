$SECRETS = az keyvault secret list --vault-name "NAME_OF_KEY_VAULT" | ConvertFrom-Json;  
$SECRETS | Select-Object -Property Name | ForEach-Object { az keyvault secret purge --vault-name "NAME_IN_KEY_VAULT" --name $_.Name  }
