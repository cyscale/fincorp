terraform {
  cloud {
    organization = "fincorp"

    workspaces {
      name = "aws-prod-eu-west-containers"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "fincorp"
    workspaces = {
      name = "aws-prod-eu-west-vpc"
    }
  }
}

locals {
  name = "ecs-prod-fincorp-containers"
  containers = {
    batch = {
      image = "497433885331.dkr.ecr.eu-west-1.amazonaws.com/batch:1.0"
      name  = "batch"
      port  = 80
    }
    test = {
      image = "hello-world:linux"
      name  = "hello"
      port  = 8080
    }
  }
}

module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "4.1.3"

  cluster_name = local.name

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        base   = 20
        weight = 50
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }
}

module "task_execution_role" {
  source = "../../modules/task_execution_role"

  environment = "prod"
}

resource "aws_ecs_task_definition" "this" {
  for_each = local.containers

  container_definitions = jsonencode([{
    essential    = true,
    image        = each.value.image,
    name         = each.value.name,
    portMappings = [{ containerPort = each.value.port }],
  }])
  cpu                      = 256
  execution_role_arn       = module.task_execution_role.role_arn
  family                   = "family-${local.name}-${each.value.name}"
  memory                   = 512
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
}

resource "aws_ecs_service" "this" {
  for_each = local.containers

  cluster         = module.ecs.cluster_id
  desired_count   = 1
  launch_type     = "FARGATE"
  name            = "${each.value.name}-service"
  task_definition = aws_ecs_task_definition.this[each.key].arn

  lifecycle {
    ignore_changes = [desired_count]
  }

  network_configuration {
    security_groups = [data.terraform_remote_state.vpc.outputs.security_groups["public"]]
    subnets         = data.terraform_remote_state.vpc.outputs.private_subnets
  }
}
