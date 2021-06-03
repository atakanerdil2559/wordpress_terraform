resource "aws_instance" "bastion_host" {
  ami                         = data.aws_ami.amazon_linux2.image_id
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  subnet_id                   = aws_subnet.public_subnet[1].id
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name

  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_bastion"
    }
  )
}