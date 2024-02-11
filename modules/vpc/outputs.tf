output "vpc_id"{
    value = aws_vpc.vpc.id
}

output "igw_id"{
    value = aws_internet_gateway.internet_gateway.id
}

output "natgw_id" {
    value = aws_nat_gateway.nat_gateway.id
}

output "natgw_eip_id" {
    value = aws_eip.eip_nat.id
}