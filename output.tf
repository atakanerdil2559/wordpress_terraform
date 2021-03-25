output "my_vpc_id" {
    value = aws_vpc.my_vpc.id
    description = "vpc id"
}
output "pub_sub_1_id" {
    value = aws_subnet.public-subnet-1.id
    description = "public subnet 1 id"
}
output "pub_sub_2_id" {
    value = aws_subnet.public-subnet-2.id
    description = "public subnet 2 id"
}
output "priv_sub_1_id" {
    value = aws_subnet.private-subnet-1.id
    description = "private subnet 1 id"
}
output "priv_sub_2_id" {
    value = aws_subnet.private-subnet-2.id
    description = "private subnet 2 id"
}
output "igw_id" {
    value = aws_internet_gateway.igw.id
    description = "internet gateway id"
}
output "nat_gw_id" {
    value = aws_nat_gateway.nat_gw.id
    description = "nat gateway id"
}
output "pub_rtp_id" {
    value = aws_route_table.pub_rtb.id
    description = "public route table id"
}
output "priv_rtp_id" {
    value = aws_route_table.private_rtb.id
    description = "private route table id"
}
output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
  description = "id of bastion sg"
}
output "wordpress_web_sg_id" {
  value = aws_security_group.wordpress_web_sg.id
  description = "id of wordpress sg"
}
output "wordpess_alb_sg_id" {
  value = aws_security_group.wordpess_alb_sg.id
  description = "id of wordpess alb sg"
}
output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
  description = "id of rds_sg"
}
output "rds_id" {
  value = aws_security_group.rds.id
  description = "id of rds database"
}
output "bastion_id" {
  value = aws_security_group.bastion_host.id
  description = "id of bastion host"
}
output "wordpess_host_id" {
  value = aws_security_group.wordpress_web.id
  description = "id of wordpess host"
}
output "wordpress_alb_id" {
  value = aws_security_group.wordpess_alb.id
  description = "id of wordpress alb"
}
output "private_key_pem" {
  value = "${module.keypair.private_key_pem}"
}
output "webserver_alb_arn" {
  value = aws_lb.webserver_alb.arn
  description = "webserver's load balancer arn"
}
output "webserver_alb_sg_name" {
  value = aws_security_group.web_alb_sg.name
  description = "webserver's load balancer security group name"
}
output "target_group_name" {
   value =  aws_lb_target_group.web_tg.name
   description = "this is a webserver's target group name"
}
output "https_listener_arns"{
  value =  aws_lb_listener.https_listener.arn 
}
output "http_listener_arns"{
  value =  aws_lb_listener.http_listener.arn 
}