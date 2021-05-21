resource "aws_instance" "wordpress_host" {
  ami                    = data.aws_ami.amazon_linux2.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.web_sg_id]
  # subnet_id = "subnet-0680b3f6358d8a9fb"
  subnet_id              = "${data.terraform_remote_state.vpc.outputs.private_subnets_ids}"
  # user_data = data.template_file.user_data.rendered
  key_name  = "bastion-key"

  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_wordpress"
    }
  )

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y php7.2",
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "wget https://wordpress.org/latest.tar.gz",
      "tar -xzf latest.tar.gz",
      "sudo yum install php-gd -y",
      "sudo yum install mysql -y",
      "sudo systemctl restart httpd",
      "sudo cp -r wordpress/* /var/www/html",
      "sudo chown -R apache:apache /var/www/html",
      "sudo systemctl restart httpd"
    ]
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    private_key = file("~/.ssh/id_rsa")
  }
}