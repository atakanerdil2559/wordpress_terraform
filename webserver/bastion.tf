resource "aws_instance" "bastion_host" {  
  ami           = data.aws_ami.amazon_linux2.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ aws_security_group.bastion_sg.id ]
  key_name = var.ssh_key_name
  tags = {
    Name = "${var.env}-bastion_host"
   }
}