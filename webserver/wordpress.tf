resource "aws_instance" "wordpress_host" {
  depends_on = [ aws_key_pair.generated_key.name ]
  ami                    =  data.aws_ami.amazon_linux2.image_id 
  instance_type          =  var.instance_type      
  vpc_security_group_ids = [ aws_security_group.wordpress_web_sg.id ]
  user_data = data.template_file.user_data.rendered
  key_name = bastion_key
  
  tags = {
    Name        = "${var.env}_wp"
    Environment = var.env
  }
}