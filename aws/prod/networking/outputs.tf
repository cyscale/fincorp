output "vpc_id" {
  value = module.vpc.vpc_id
}

output "security_groups" {
  value = module.vpc.security_groups
}
