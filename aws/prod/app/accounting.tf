module "ec2_accounting" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                        = "ec2-accounting-prod"
  ami                         = data.aws_ami.amazon_linux2.id
  instance_type               = "t2.micro"
  availability_zone           = local.availability_zone
  subnet_id                   = element(data.terraform_remote_state.vpc.outputs.public_subnets, 0)
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_groups["public"]]
  associate_public_ip_address = true
  volume_tags                 = local.tags

  tags = local.tags
}

resource "aws_volume_attachment" "this" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.this.id
  instance_id = module.ec2_accounting.id
}

resource "aws_ebs_volume" "this" {
  availability_zone = local.availability_zone
  size              = 1
  encrypted         = false
}

module "s3_accounting_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "fincorp-accounting-bucket"
  acl    = "public-read"

  lifecycle_rule = [
    {
      id      = "log"
      enabled = true

      transition = [
        {
          days          = 30
          storage_class = "ONEZONE_IA"
          }, {
          days          = 60
          storage_class = "GLACIER"
        }
      ]
    }
  ]
}
