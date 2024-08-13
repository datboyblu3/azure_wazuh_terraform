$tenantId = "" 
$resourceGroup = "" 
$keyvaultName = ""

# Login
az login -t $tenantId

$allSecrets = az keyvault secret list --vault-name $keyVaultName | 
ConvertFrom-Json                        

foreach($item in $allSecrets)
{
  az keyvault secret delete --name $item.name --vault-name $keyvaultName

  az keyvault secret purge --name $item.name --vault-name $keyvaultName       
}
