data "aws_availability_zones" "azs" {}

resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "public" {
  count = var.public_sn_count

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.azs.names, count.index)
}

resource "aws_subnet" "private" {
  count = var.private_sn_count

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_cidrs[count.index]
  availability_zone = element(data.aws_availability_zones.azs.names, count.index)
}

resource "aws_db_subnet_group" "this" {
  subnet_ids = aws_subnet.private[*].id
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route" "default" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = local.any_ip
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_default_route_table" "private" {
  default_route_table_id = aws_vpc.this.default_route_table_id
}

resource "aws_route_table_association" "public" {
  count = var.public_sn_count

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "this" {
  for_each = var.security_groups

  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.this.id

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    cidr_blocks = [local.any_ip]
    description = "Allow all egress traffic"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
}
