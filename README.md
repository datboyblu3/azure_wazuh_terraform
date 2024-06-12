# Wazuh Azure Terraform Deployment


![Untitled-2024-06-10-2030](https://github.com/datboyblu3/azure_wazuh_terraform/assets/95729902/7ff8a185-9df1-43e4-8586-1ab512bb5751)

Using Terraform to automate the deployment of the Wazuh architecture: Indexer, Server and Dashboard in Azure

## Short Descriptions of Each TF Module
```
├── 0-providers.tf <- Azure config
├── 1-key_resources.tf <- Creates .pem and .pem.pub generation
├── 2-security_group.tf <- security groups creation
├── 3-ec2_instances.tf <- instances specification
├── 4-provision.tf <- instance configuration at SO level
├── 5-outputs.tf <- Ouput variable
```

```
├── configure-indexer.yml <- indexer installation process
├── configure-server.yml <- server installation process
├── configure-dashboard.yml <- dashboard installation commands
```
## Detailed Explanation

## How to Use This
```python
terraform init
```

```python
terraform plan
```

```python
terraform apply -auto-approve
```
