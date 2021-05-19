variable "key_name" {
  default = "bastion_key"
  type    = string
}

resource "tls_private_key" "bastion_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.bastion_key.public_key_openssh
}

# this resource blocks generated keys and stores it in state file,
# it is not a good practice to pass around a private key but for temporary dev environment where you 
# don't need to pass the key is ok.

# key_name      = aws_key_pair.generated_key.key_name