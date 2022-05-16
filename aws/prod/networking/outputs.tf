output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "security_groups" {
  value = module.vpc.security_groups
}

output "db_subnet_group_name" {
  value = module.vpc.db_subnet_group_name
}
