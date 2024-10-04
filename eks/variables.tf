locals {
  name   = "eks-terraform"
  region = "us-east-1"

  tags = {
    Environment = local.environment
  }

  environment = "production"
}
