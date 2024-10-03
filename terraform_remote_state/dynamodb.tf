module "dynamodb_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "4.1.0"

  deletion_protection_enabled = false

  name        = "terraform-remote-state-lock"
  hash_key    = "LockID"
  table_class = "STANDARD"

  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1

  attributes = [
    {
      name = "LockID"
      type = "S"
    }
  ]
}
