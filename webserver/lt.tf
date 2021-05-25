# Launch Template
resource "aws_launch_template" "web_template" {
  name_prefix            = "${var.env}_web_template"
  image_id               = data.aws_ami.amazon_linux2.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.web_sg_id]

  lifecycle {
    create_before_destroy = true
  }
  user_data = filebase64("${path.module}/user_data.sh")

  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_web_lt"
    }
  )
}