resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-${var.resource_type}-ni"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip}"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.application_type}-${var.resource_type}-vm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_DS2_v2"
  admin_username      = "${var.admin_username}"
  admin_password      = "${var.admin_password}"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.test.id]
  admin_ssh_key {
    username   = "${var.admin_username}"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCoIPWtrCoec91VUh3ockRAaBCJ8jOopDdl0gNRTV6JQFILYcUhw9you8EDhsSVWUDRfP9ffa3tzWusBVBW6CInoDqdk67ldGMvC2XxiCIdcoQ/Yq/IHJTtdIVul6BUe+NJjkKJPNKapdO0yBFTi/ah7CNL+E+TK4UzqxSpIYq7PEkvq6auWRg+Pv0A4drLGtK78Yg6suIxrqzpzB7Lhk7fv1ixlBC01xOohOo1VsffCgzKd29WO5NZjE3qicAHZRnvnStKVwg3p++Ddc06xm7Eaf07xw+jCZV9sKV6Nm2q5thpgMErzs3vMeSm6uc+ghgCj/wbo4fpzgZ2qFeT02VvreXiG2rHom+VjZAwCbsaLueOlRTPLcPmGJ0fP3BSxMapFkxrydkZKgqLUI9dop3MWItrxOUFn10fljiTBX9YXdOQgTkvpDYVj6oLBDgjoHJ8OgxmlWBDaMCPa78seoUipVyBI5/9i+aTQVGSSCHztc9n3phel5+DzX7JCKobwHc= devopsagent@NhatLinuxVM"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
