provider "local" {}

provider "tls" {}


resource "tls_private_key" "rsa_4096_aks" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_private_key" {
  content         = tls_private_key.rsa_4096_aks.private_key_pem
  filename        = pathexpand("~/.ssh/jb-aks.pem")
  file_permission = "0400"

}