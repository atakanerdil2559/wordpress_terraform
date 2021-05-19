output "vpc_id" {
  value = aws_vpc.my_vpc.id
}
output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}
output "private_subnets_ids" {
  value = aws_subnet.private_subnet[*].id
}
output "igw_id" {
  value       = aws_internet_gateway.igw.id
  description = "internet gateway id"
}
output "nat_gw_id" {
  value       = aws_nat_gateway.nat_gw.id
  description = "nat gateway id"
}
output "pub_rtp_id" {
  value       = aws_route_table.pub_rtb.id
  description = "public route table id"
}
output "priv_rtp_id" {
  value       = aws_route_table.private_rtb.id
  description = "private route table id"
}

# Security groups
output "bastion_sg_id" {
  value       = aws_security_group.bastion_sg.id
  description = "id of bastion sg"
}
output "web_sg_id" {
  value       = aws_security_group.wordpress_web_sg.id
  description = "id of wordpress sg"
}
output "web_lb_sg_id" {
  value       = aws_security_group.wordpess_alb_sg.id
  description = "id of wordpess alb sg"
}
output "rds_sg_id" {
  value       = aws_security_group.rds_sg.id
  description = "id of rds_sg"
}