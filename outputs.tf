output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "ig" {
    value = aws_internet_gateway.ig.id
}