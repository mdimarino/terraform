terraform {
  required_version = ">= 1.9.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.69.0"
    }
  }

  # terraform init -backend-config="bucket=471112514740-us-east-1-terraform-remote-state" -backend-config="key=terraform/state/vpc-exemplo/terraform.tfstate" -backend-config="region=us-east-1" -backend-config="dynamodb_table=terraform-remote-state-lock" -backend-config="profile=acg-sandbox"
  backend "s3" {
    profile        = "acg-sandbox"
    bucket         = "975049911685-us-east-1-terraform-remote-state"
    key            = "terraform/state/vpc/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-remote-state-lock"
  }
}
