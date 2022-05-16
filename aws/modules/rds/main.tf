resource "aws_db_instance" "this" {
  allocated_storage      = var.storage_size
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.name
  username               = var.user
  password               = var.pass
  db_subnet_group_name   = var.subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  identifier             = var.identifier
  skip_final_snapshot    = var.skip_snapshot
}
