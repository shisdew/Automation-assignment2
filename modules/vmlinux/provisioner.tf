resource "null_resource" "linux_provisioner" {
  count      = var.nb_count
  depends_on = [azurerm_linux_virtual_machine.linux-vm]

  provisioner "local-exec" {
    #inline = ["/usr/bin/hostname"]
    command = "sleep 10; ansible-playbook groupX-playbook.yaml; echo hostname"

    connection {
      type     = "ssh"
      user     = var.admin_username
      password = var.admin_password
      #private_key = file(var.priv_key)
      host = element(azurerm_public_ip.linux-pip[*].fqdn, count.index + 1)
    }
  }
}

