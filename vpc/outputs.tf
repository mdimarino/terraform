output "aws_account_id" {
  description = "AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnets_ids" {
  description = "Private Subnet IDs"
  value       = module.vpc.private_subnets
}

output "public_subnets_ids" {
  description = "Public Subnet IDs"
  value       = module.vpc.public_subnets
}
