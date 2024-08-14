variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Azure Key Vault"
  type        = string
}

variable "ssh_key_names" {
  description = "List of SSH key names in Key Vault"
  type        = list(string)
}

variable "vm_names" {
  description = "List of VM names"
  type        = list(string)
}
