output "LB_ARN"{
    value = aws_lb.load_balancer.arn
}

output "LB_DOMAIN_ADDRESS" {
    value = aws_lb.load_balancer.dns_name
}