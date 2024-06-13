# Wazuh Azure Terraform Deployment


![Untitled-2024-06-10-2030](https://github.com/datboyblu3/azure_wazuh_terraform/assets/95729902/7ff8a185-9df1-43e4-8586-1ab512bb5751)

Using Terraform to automate the deployment of the Wazuh architecture: Indexer, Server and Dashboard in Azure

## Short Descriptions of Each TF Module
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

## How to Use This

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
