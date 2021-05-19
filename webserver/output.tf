output "bastion_id" {
  value       = aws_security_group.bastion_host.id
  description = "id of bastion host"
}
output "wordpess_host_id" {
  value       = aws_security_group.wordpress_web.id
  description = "id of wordpess host"
}
output "wordpress_alb_id" {
  value       = aws_security_group.wordpess_alb.id
  description = "id of wordpress alb"
}
output "private_key_pem" {
  value = module.keypair.private_key_pem
}