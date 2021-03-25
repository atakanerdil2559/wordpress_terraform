###  Bastion Host Security Group
resource "aws_security_group" "bastion_sg" {
  name        = "${var.env}-bastion_sg"
  description = "Allow http inbound traffic to alb"
  tags = {
    Name  = "${var.env}-bastion_sg"
  }
}
resource "aws_security_group_rule" "bastion_ssh_ingress_from_wordpress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = aws_security_group.wordpress_web_sg.id
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

###  WordPress Host security group
resource "aws_security_group" "wordpress_web_sg" {
  name        = "${var.env}-wordpress_web_sg"
  description = "Allow http inbound traffic to alb"
  tags = {
    Name  = "${var.env}-wordpress_web_sg"
  }
}
resource "aws_security_group_rule" "wordpress_ssh_ingress_from_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = aws_security_group.bastion_sg.id
  security_group_id = aws_security_group.wordpress_web_sg.id
}
resource "aws_security_group_rule" "wordpress_http_ingress_from_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = aws_security_group.wordpess_alb_sg.id
  security_group_id = aws_security_group.wordpress_web_sg.id
}
resource "aws_security_group_rule" "wordpress_mysql_ingress_from_rds" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = aws_security_group.rds_sg.id
  security_group_id = aws_security_group.wordpress_web_sg.id
}
resource "aws_security_group_rule" "wordpress_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.wordpress_web_sg.id
}

### application load balancer security group
resource "aws_security_group" "wordpress_alb_sg" {
  name        = "${var.env}-app_alb_sg"
  description = "Allow http and https inbound traffic"
  tags = {
    Name  = "${var.env}-alb-sg"
  }
}
resource "aws_security_group_rule" "wordpress_alb_sg_http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.wordpess_alb_sg.id
}
resource "aws_security_group_rule" "webserver_lb_sg_https_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.wordpess_alb_sg.id
}
resource "aws_security_group_rule" "wordpress_alb_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.wordpess_alb_sg.id
}

### rds database security group ###
resource "aws_security_group" "rds_sg" {
  name        = "${var.env}-rds-sg"
  description = "allow from self and local laptop"

  tags = {
    Name = "${var.env}-rds-sg"
  }
}
resource "aws_security_group_rule" "self" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = aws_security_group.wordpress_web_sg.id
  security_group_id = aws_security_group.rds_sg.id
}