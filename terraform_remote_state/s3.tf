module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  force_destroy = true

  bucket = "${data.aws_caller_identity.current.account_id}-${local.region}-terraform-remote-state"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }

  lifecycle_rule = [
    {
      enabled = true

      id = "Delete noncurrent version after 90 days"
      noncurrent_version_expiration = {
        days = 90
      }
    }
  ]

  tags = {
    Name = "${data.aws_caller_identity.current.account_id}-${local.region}-terraform-remote-state"
  }
}
