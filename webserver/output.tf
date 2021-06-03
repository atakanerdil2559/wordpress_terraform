output "wordpress_lb_id" {
  value       = aws_lb.web_lb.id
  description = "id of wordpress alb"
}