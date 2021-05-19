resource "aws_instance" "wordpress_host" {
  # depends_on = [ aws_key_pair.generated_key.name ]
  ami                    = data.aws_ami.amazon_linux2.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = ["data.terraform_remote_state.vpc.outputs.web_sg_id"]
  # subnet_id              = "subnet-099e148bc73b73598"
  # subnet_id              = data.terraform_remote_state.vpc.outputs.private_subnets_ids
  user_data = data.template_file.user_data.rendered
  key_name  = "bastion-key"

  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_wordpress"
    }
  )
}