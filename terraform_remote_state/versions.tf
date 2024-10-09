terraform {
  required_version = ">= 1.9.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.69.0"
    }
  }

  # terraform init -backend-config="bucket=471112514740-us-east-1-terraform-remote-state" -backend-config="key=terraform/state/terraform_remote_state/terraform.tfstate" -backend-config="region=us-east-1" -backend-config="dynamodb_table=terraform-remote-state-lock" -backend-config="profile=acg-sandbox"
  # backend "s3" {
  #   profile        = "acg-sandbox"
  #   bucket         = "992382546373-us-east-1-terraform-remote-state"
  #   key            = "terraform/state/terraform_remove_state/terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-remote-state-lock"
  # }
}
