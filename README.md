# Wazuh Azure Terraform Deployment


![Untitled-2024-06-10-2030](https://github.com/datboyblu3/azure_wazuh_terraform/assets/95729902/7ff8a185-9df1-43e4-8586-1ab512bb5751)

Using Terraform to automate deployment of the Wazuh Indexer, Server and Dashboard in Azure

```
├── 0-providers.tf <- Azure config
├── 1-ami.tf <- AMI Base 
├── 2-key_resources.tf <- .pem and .pem.pub generation
├── 3-security_group.tf <- security groups
├── 4-ec2_instances.tf <- instances specification
├── 5-provision.tf <- instance configuration at SO level
├── 6-outputs.tf <- Ouput variable
```

```
├── configure-indexer.yml <- indexer installation process
├── configure-server.yml <- server installation process
├── configure-dashboard.yml <- dashboard installation commands
```
