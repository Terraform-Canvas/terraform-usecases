# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "main-vpc"
  cidr = var.vpc_cidr_block

  azs             = data.aws_availability_zones.available.names
  private_subnets = slice(var.private_subnet_cidr_blocks, 0, var.private_subnet_count)
  public_subnets  = slice(var.public_subnet_cidr_blocks, 0, var.public_subnet_count)

  enable_nat_gateway = true
  enable_vpn_gateway = var.enable_vpn_gateway
}

module "app_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/web"
  version = "4.17.1"

  name        = "web-sg"
  description = "Security group for web-servers with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
}

module "lb_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/web"
  version = "4.17.1"

  name        = "lb-sg"
  description = "Security group for load balancer with HTTP ports open to world"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "random_pet" "app" {
  length    = 2
  separator = "-"
}

resource "aws_lb" "app" {
  name               = "main-app-${random_pet.app.id}-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups    = [module.lb_security_group.security_group_id]
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.blue.arn
        weight = lookup(local.traffic_dist_map[var.traffic_distribution], "blue", 100)
      }
      target_group {
        arn    = aws_lb_target_group.green.arn
        weight = lookup(local.traffic_dist_map[var.traffic_distribution], "green", 0)
      }
      stickiness {
        enabled  = false
        duration = 1
      }
    }
  }
}
