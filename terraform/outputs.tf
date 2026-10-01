output "alb_dns_name" {
  value       = aws_lb.app.dns_name
  description = "Available only after an approved apply; no apply is part of this project."
}
