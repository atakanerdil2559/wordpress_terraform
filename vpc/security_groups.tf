# Bastion Host Security Group
resource "aws_security_group" "bastion_sg" {
  name        = "${var.env}_bastion_sg"
  description = "Allow http inbound traffic to alb"
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_bastion_sg"
    }
  )
}
resource "aws_security_group_rule" "ssh_ingress_webserver" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_sg.id
  security_group_id        = aws_security_group.bastion_sg.id
}
resource "aws_security_group_rule" "ssh_ingress_local_laptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["108.210.198.102/32"]
  security_group_id = aws_security_group.bastion_sg.id
}
resource "aws_security_group_rule" "bastion_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_sg.id
}

# WordPress Host security group
resource "aws_security_group" "web_sg" {
  name        = "${var.env}_wordpress_sg"
  description = "Allow http inbound traffic to alb"
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_wordpress_sg"
    }
  )
}
resource "aws_security_group_rule" "web_ssh_ingress" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion_sg.id
  security_group_id        = aws_security_group.web_sg.id
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
resource "aws_security_group_rule" "webserver_lb_sg_https_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_lb_sg.id
}
resource "aws_security_group_rule" "wordpress_alb_sg_egress" {
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
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_rds_sg"
    }
  )
}
resource "aws_security_group_rule" "rds_ingress_mysql" {
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