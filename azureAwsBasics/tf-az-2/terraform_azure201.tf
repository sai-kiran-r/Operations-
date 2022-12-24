provider "azurerm" {
    features {} 
}

# create a resource group
resource "azurerm_resource_group" "rg201" { 
    name = "terraform201"
    location = var.resource_group_location
}

# create a virtual network
resource "azurerm_virtual_network" "network201" {
    name = "myVnet"
    address_space = ["10.0.0.0/16"]
    location = azurerm_resource_group.rg201.location 
    resource_group_name = azurerm_resource_group.rg201.name
}

# create subnet
resource "azurerm_subnet" "subnet201" {
    name = "mySubnet"
    resource_group_name = azurerm_resource_group.rg201.name 
    virtual_network_name = azurerm_virtual_network.network201.name 
    address_prefixes = ["10.0.1.0/24"]
}

# create public IPs
resource "azurerm_public_ip" "ips201" {
    name = "myPublicIP"
    location = azurerm_resource_group.rg201.location 
    resource_group_name = azurerm_resource_group.rg201.name 
    allocation_method = "Dynamic"

    tags = {
        environment = "TerraformDemo"
    } 
}

# create NSG and ssh rule
resource "azurerm_network_security_group" "nsg201" {
    name = "myNetworkSecurityGroup"
    location = azurerm_resource_group.rg201.location 
    resource_group_name = azurerm_resource_group.rg201.name

    security_rule { 
        name = "SSH"
        priority = 1001
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "22"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }
    tags = {
        environment = "Terraform Demo"
    } 
}

# create network interface
resource "azurerm_network_interface" "nic201" {
    name = "myNIC"
    location = azurerm_resource_group.rg201.location 
    resource_group_name = azurerm_resource_group.rg201.name

    ip_configuration {
        name = "myNicConfiguration"
        subnet_id = azurerm_subnet.subnet201.id 
        private_ip_address_allocation = "Dynamic" 
        public_ip_address_id = azurerm_public_ip.ips201.id
    } 
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" { 
    network_interface_id = azurerm_network_interface.nic201.id 
    network_security_group_id = azurerm_network_security_group.nsg201.id
}

# random id
resource "random_id" "randomId" { 
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = azurerm_resource_group.rg201.name 
    }
    byte_length = 8 
}

# create storage account for boot diagnostics
resource "azurerm_storage_account" "storage201" {
    name = "diag${random_id.randomId.hex}" 
    resource_group_name = azurerm_resource_group.rg201.name 
    location = azurerm_resource_group.rg201.location
        account_replication_type = "LRS" 
        account_tier = "Standard"
    tags = {
        environment = "staging"
    } 
}

# Create (and display) an SSH key
resource "tls_private_key" "example_ssh" { 
    algorithm = "RSA"
    rsa_bits = 4096
}

# create virtual machine
resource "azurerm_linux_virtual_machine" "vm201" {
    name = "myTfVm"
    location = azurerm_resource_group.rg201.location 
    resource_group_name = azurerm_resource_group.rg201.name 
    network_interface_ids = [azurerm_network_interface.nic201.id] 
    size = "Standard_DS1_v2"
    
    source_image_reference { 
        publisher = "Canonical" 
        offer = "UbuntuServer" 
        sku = "18.04-LTS" 
        version = "latest"
    }
    os_disk {
        name = "myOsDisk"
        caching = "ReadWrite" 
        storage_account_type = "Premium_LRS"
    }

    computer_name = "saiVM" 
    admin_username = "sai" 
    disable_password_authentication = true

    admin_ssh_key { 
        username = "sai"
        public_key = tls_private_key.example_ssh.public_key_openssh
    }
        boot_diagnostics {
            storage_account_uri = azurerm_storage_account.storage201.primary_blob_endpoint
        }
    tags = {
    environment = "staging"
    } 
}
