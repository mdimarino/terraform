module "vpc_flow_logs_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  bucket = "${data.aws_caller_identity.current.account_id}-flow-logs"

  force_destroy = true

  lifecycle_rule = [
    {
      id      = "all-flow-logs"
      enabled = true

      transition = [
        {
          days          = 60
          storage_class = "ONEZONE_IA"
          }, {
          days          = 120
          storage_class = "GLACIER"
        }
      ]

      expiration = {
        days = 180
        # expired_object_delete_marker = true
      }
    }
  ]

  #   logging = {
  #     target_bucket = "${data.aws_caller_identity.current.account_id}-us-east-1-s3-central-access-logs"
  #     target_prefix = ""
  #     target_object_key_format = {
  #       partitioned_prefix = {
  #         partition_date_source = "DeliveryTime" # "EventTime"
  #       }
  #       # simple_prefix = {}
  #     }
  #   }
}
