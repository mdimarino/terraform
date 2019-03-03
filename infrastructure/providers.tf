provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "${var.profile}"
}

terraform {
  required_version = ">= 0.11.11"
  backend "s3" {
    bucket  = "zoom-dev-s3-terraform-state-storage"
    key     = "network"
    region  = "us-east-1"
    encrypt = true
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}
