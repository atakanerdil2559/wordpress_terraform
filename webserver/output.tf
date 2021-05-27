output "wordpress_lb_id" {
  value       = aws_lb.web_lb.id
  description = "id of wordpress alb"
}

# output "private_key_pem" {
#   value = module.keypair.private_key_pem
# }