variable "resource_group_name_prefix" {
    default = "rg"
    description = "Prefix of resource group name combined with random ID so name is unique in Azure"
}

variable "resource_group_location" {
    default = "eastus"
    description = "Location of the resource group."
}