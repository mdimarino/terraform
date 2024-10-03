locals {
  name   = "vpc-exemplo"
  region = "us-east-1"

  tags = {
    Environment = local.environment
  }

  environment = "production"
}
