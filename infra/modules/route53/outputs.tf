output "record_name" {
  description = "Route53 record name"
  value       = aws_route53_record.main.name
}

output "record_fqdn" {
  description = "Route53 record FQDN"
  value       = aws_route53_record.main.fqdn
}
