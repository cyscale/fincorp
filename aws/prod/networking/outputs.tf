output "vpc_id" {
  value = module.vpc.vpc_id
}

output "security_groups" {
  value = module.vpc.security_groups
}

output "db_subnet_group_name" {
  value = module.vpc.db_subnet_group_name
}
