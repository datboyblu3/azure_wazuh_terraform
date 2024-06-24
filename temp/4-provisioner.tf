######################################################################################
# Provisions the Wazuh Indexer, Server and Dashboard Nodes
######################################################################################

resource "null_resource" "configure_indexer"{
    depends_on = [
        azurerm_linux_virtual_machine.az-indexer_1
    ]

    provisioner "remote-exec" {

        inline = [

        ]

        connection {
            host        = coalesce()
            agent       = true 
            type        = "ssh"
            user        = "adminuser"
            private_key = tls_private_key.indexer_key.private_key_pem


    }
    }
}
