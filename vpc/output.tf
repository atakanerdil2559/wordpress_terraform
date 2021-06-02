output "vpc_id" {
  value = aws_vpc.my_vpc.id
}
output "public_subnet_one" {
  value = aws_subnet.public_subnet[0].id
}
output "public_subnet_two" {
  value = aws_subnet.public_subnet[1].id
}
output "public_subnet_three" {
  value = aws_subnet.public_subnet[2].id
}
# output "private_subnets_ids" {
#   value = aws_subnet.private_subnet[*].id
# }
# output "public_subnet_ids" {
#   value = aws_subnet.public_subnet[*].id
# }
output "private_subnets_one" {
  value = aws_subnet.private_subnet[0].id
}
output "private_subnets_two" {
  value = aws_subnet.private_subnet[1].id
}
output "private_subnets_three" {
  value = aws_subnet.private_subnet[2].id
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
output "web_sg_id" {
  value       = aws_security_group.web_sg.id
  description = "id of wordpress sg"
}
output "web_lb_sg_id" {
  value       = aws_security_group.web_lb_sg.id
  description = "id of wordpess alb sg"
}
output "rds_sg_id" {
  value       = aws_security_group.rds_sg.id
  description = "id of rds_sg"
}