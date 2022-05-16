output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.this[*].name
}

output "security_groups" {
  value = { for k, v in aws_security_group.this : k => v.id }
}
