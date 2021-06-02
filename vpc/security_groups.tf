# WordPress Host security group
resource "aws_security_group" "web_sg" {
  name        = "${var.env}_wordpress_sg"
  description = "Allow http inbound traffic to alb"
  vpc_id      = aws_vpc.my_vpc.id
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_wordpress_sg"
    }
  )
}
resource "aws_security_group_rule" "web_ssh_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["108.210.198.102/32"]
  security_group_id = aws_security_group.web_sg.id
}
resource "aws_security_group_rule" "web_http_ingress" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_lb_sg.id
  security_group_id        = aws_security_group.web_sg.id
}
resource "aws_security_group_rule" "web_mysql_ingress" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.rds_sg.id
  security_group_id        = aws_security_group.web_sg.id
}
resource "aws_security_group_rule" "web_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_sg.id
}

# Application Load Balancer security group
resource "aws_security_group" "web_lb_sg" {
  name        = "${var.env}_web_lb_sg"
  description = "Allow http and https inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_alb_sg"
    }
  )
}
resource "aws_security_group_rule" "lb_http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_lb_sg.id
}
resource "aws_security_group_rule" "lb_https_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_lb_sg.id
}
resource "aws_security_group_rule" "lb_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_lb_sg.id
}

### RDS database security group ###
resource "aws_security_group" "rds_sg" {
  name        = "${var.env}_rds_sg"
  description = "allow from self and local laptop"
  vpc_id      = aws_vpc.my_vpc.id
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_rds_sg"
    }
  )
}
resource "aws_security_group_rule" "rds_mysql_ingress" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_sg.id
  security_group_id        = aws_security_group.rds_sg.id
}
resource "aws_security_group_rule" "local_laptop" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["108.210.198.102/32"]
  security_group_id = aws_security_group.rds_sg.id
}