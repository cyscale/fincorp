resource "azurerm_public_ip" "this" {
  name                = "public-ip-${var.name}"
  resource_group_name = var.resource_group
  location            = var.location
  allocation_method   = "Dynamic"

  tags = var.tags
}

resource "azurerm_network_interface" "this" {
  name                = "nic-${var.name}"
  resource_group_name = var.resource_group
  location            = var.location

  ip_configuration {
    name                          = "public"
    subnet_id                     = var.subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "this" {
  name                            = "vm-${var.name}"
  resource_group_name             = var.resource_group
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = "adminuser"
  admin_password                  = "CyscaleDemo1!"
  network_interface_ids           = [azurerm_network_interface.this.id]
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = var.tags
}
