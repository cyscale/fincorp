module "ec2_ledger" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                        = "ec2-ledger-prod"
  ami                         = data.aws_ami.amazon_linux2.id
  instance_type               = "t2.micro"
  availability_zone           = local.availability_zone
  subnet_id                   = element(data.terraform_remote_state.vpc.outputs.public_subnets, 0)
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_groups["public"]]
  associate_public_ip_address = true
  iam_instance_profile        = data.terraform_remote_state.iam.outputs.instance_profile
  volume_tags                 = local.tags

  tags = local.tags
}
