resource "aws_instance" "bastion_host" {
  ami                         = data.aws_ami.amazon_linux2.image_id
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  subnet_id                   = aws_subnet.public_subnet[1].id
  associate_public_ip_address = true
  key_name                    = "new-key"
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_bastion"
    }
  )
}

variable "key_name" {
  default = "bastion-key"
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