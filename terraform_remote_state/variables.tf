locals {
  name        = "terraform-remote-state"
  region      = "us-east-1"
  environment = "production"

  tags = {
    Environment = local.environment
  }
}
