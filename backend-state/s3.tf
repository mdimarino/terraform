resource "aws_s3_bucket" "s3-terraform-state-storage" {
  bucket = "${var.backend-bucket}"
  acl = "private"
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = false
  }
  tags {
    Name = "S3 Remote Terraform State Store",
    Environment = "${var.environment}",
    Billing = "${var.billing}"
  }
}
