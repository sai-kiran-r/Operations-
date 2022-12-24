# Configure the Microsoft Azure Provider 
provider "azurerm" {
features {} 
}
# create a resource group
resource "azurerm_resource_group" "helloterraform" {
name = "terraformtest"
location = "East US" 
}