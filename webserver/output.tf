output "wordpess_host_id" {
  value       = aws_instance.wordpress_host.id
  description = "id of wordpess host"
}

output "wordpress_alb_id" {
  value       = aws_lb.web_lb.id
  description = "id of wordpress alb"
}

# output "private_key_pem" {
#   value = module.keypair.private_key_pem
# }