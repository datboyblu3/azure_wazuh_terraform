# Wazuh Azure Terraform Deployment

![Untitled-2024-06-26-1305](https://github.com/datboyblu3/azure_wazuh_terraform/assets/95729902/e10d0d65-a915-4e90-9c3a-26643fab1f4f)


Using Terraform to automate the deployment of the Wazuh architecture: Indexer, Server and Dashboard in Azure.

## Terraform Modules
```
├── 0-providers.tf <- Azure config
├── 1-key_resources.tf <- Creates .pem and .pem.pub generation
├── 2-network.tf <- creates virtual network and subnet
├── 3-security_group.tf <- security groups creation
├── 4-compute.tf <- virtual machines
├── 5-provision.tf <- executes ansible wazuh files
├── 6-outputs.tf <- Ouput options
```

```
├── configure-indexer.yml <- indexer installation process
├── configure-server.yml <- server installation process
├── configure-dashboard.yml <- dashboard installation commands
```

## Usage

This directory is a self contained production ready environment. You can clone
this repository and run terraform from within this directory or copy the files
elsewhere.

### Install Azure CLI

**macOS**
```python
brew update && brew install azure-cli
```

**Linux (Ubuntu, Debian)**
```python
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```
**Windows**
``` python
https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli)
```

### az key vault commands 

[az keyvault secret](https://learn.microsoft.com/en-us/cli/azure/keyvault/secret?view=azure-cli-latest#az-keyvault-secret-purge)

### IMPORTANT: Azure KeyVault

This project will use the Azure KeyVault to store the SSH keys for the Wazuh Indexer, Server and Dashboard. This way, the potential for keys to be committed to GitHub is lowered.
This step has two pre-requisites: 
1) You must generate the SSH keys yourself.
2) Add your user as a `Key Vault Administrator` via your key vault's IAM policy.
   
> NOTE: Azure only accepts RSA type for SSH

### Generate SSH Keys

**Step 1: Generate RSA SSH Keys**
```python
 ssh-keygen -t rsa -b 4096 -C "windexer"
```

```python
 ssh-keygen -t rsa -b 4096 -C "server"
```

```python
 ssh-keygen -t rsa -b 4096 -C "dashboard"
```

**Step 2: Configure Azure KeyVault**

This step covers the details to configure your Azure Key Vault
> *After generating your SSH keys, store the public key in a variable. Use this variable when adding the public key to the vault. DESTROY THE VARIABLE AFTER YOU HAVE STORED IT IN THE VAULT*
```
SSH_PUBLIC_KEY="$(cat example_key.pub)"
```

- Create a resource group
  ```python
  az group create --name "myResourceGroup" --location "EastUS"
  ```
- Create a key vault
  ```python
  az keyvault create --name "<your-unique-keyvault-name>" --resource-group "myResourceGroup" --enable-rbac-authorization
  ```
- Give your user account permissions to manage secrets in Key Vault
  ```python
  az role assignment create --role "Key Vault Secrets User" --assignee "<example_outlook.com#EXT#example@outlook.onmicrosoft.com>" --scope "/subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.KeyVault/vaults/<your-unique-keyvault-name>"
  ```

- Add a secret to Key Vault
  ```python
  az keyvault secret set --vault-name "<your-unique-keyvault-name>" --name "ExamplePassword" --value "$SSH_PUBLIC_KEY" --output none
  ```
### Assign Key Vault Administrator role to User

1) ![keyvault_1](https://github.com/datboyblu3/azure_wazuh_terraform/assets/95729902/e8f715c7-9697-49e3-bfec-d162fea5b5ab)

2) ![keyvault_2](https://github.com/datboyblu3/azure_wazuh_terraform/assets/95729902/19f9471b-d3ff-4abf-a826-b72f45a18db8)

3) ![keyvault_3](https://github.com/datboyblu3/azure_wazuh_terraform/assets/95729902/ca82a235-4a5e-4123-8a08-3809478efd6f)

4) ![keyvault_4](https://github.com/datboyblu3/azure_wazuh_terraform/assets/95729902/c1a1b0de-37d8-4ac9-9709-95360c90202a)


### Storing the Terraform State File in Terraform Cloud

- Find original artical [here](https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-migrate)


### Common Terraform Commands

```python
terraform init
```

```python
terraform plan
```

```python
terraform apply -auto-approve
```

```python
terraform state list
```

```python
terraform state show NAME_OF_RESOURCE_GROUP
```

```python
terraform destroy -auto-approve
```

## Troubleshooting

If you receive an "GH001: Large files detected" message execute the following command replacing 'EXAMPLE_FILE' with the offending file
```python
git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch EXAMPLE_FILE'
```

