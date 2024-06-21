# Wazuh Azure Terraform Deployment

![awt](https://github.com/datboyblu3/azure_wazuh_terraform/assets/95729902/6e5523c4-9b6c-4aee-80fd-ea68e7d2f922)



Using Terraform to automate the deployment of the Wazuh architecture: Indexer, Server and Dashboard in Azure

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

[az Windows Install](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli)

### IMPORTANT:Azure KeyVault

This project will use the Azure KeyVault to store the SSH keys for the Wazuh Indexer, Server and Dashboard. This way, no keys would be committed to GitHub.
This step requires a *pre-requisite: You must generate the SSH keys yourself.* 
> NOTE: Azure only accepts RSA type for SSH

**Step 1: Generate SSH Keys**
```python
 ssh-keygen -t rsa -b 4096 -C "wazuh_indexer"
```

**Step 2: Configure Azure KeyVault**

This step covers the details to configure your Azure KeyVault

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
  az role assignment create --role "Key Vault Secrets User" --assignee "<your-email-address>" --scope "/subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.KeyVault/vaults/<your-unique-keyvault-name>"
  ```
- Add a secret to Key Vault
  ```python
  az keyvault secret set --vault-name "<your-unique-keyvault-name>" --name "ExamplePassword" --value "hVFkk965BuUv"
  ```



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
