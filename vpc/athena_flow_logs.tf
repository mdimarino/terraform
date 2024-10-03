resource "aws_athena_workgroup" "vpc" {
  name = "flow_logs"

  configuration {
    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = true

    result_configuration {
      output_location = "s3://${module.vpc_flow_logs_bucket.s3_bucket_id}/athena_output/"

      encryption_configuration {
        encryption_option = "SSE_S3"
      }
    }
  }
}

resource "aws_athena_database" "vpc" {
  name   = "flow_logs"
  bucket = module.vpc_flow_logs_bucket.s3_bucket_id

  force_destroy = true
}

# Esta declaração SQL deve ser executada na console para criar a tabela. Ela está
# em 'Saved queries'
resource "aws_athena_named_query" "vpc_create_table_vpc_flow_logs" {
  name        = "${local.name}_create_table_vpc_flow_logs"
  workgroup   = aws_athena_workgroup.vpc.id
  database    = aws_athena_database.vpc.name
  query       = "CREATE EXTERNAL TABLE IF NOT EXISTS `vpc_flow_logs_${local.name}` (version int, account_id string, interface_id string, srcaddr string, dstaddr string, srcport int, dstport int, protocol bigint, packets bigint, bytes bigint, start bigint, `end` bigint, action string, log_status string, vpc_id string, subnet_id string, instance_id string, tcp_flags int, type string, pkt_srcaddr string, pkt_dstaddr string, region string, az_id string, sublocation_type string, sublocation_id string, pkt_src_aws_service string, pkt_dst_aws_service string, flow_direction string, traffic_path int) PARTITIONED BY (`date` date) ROW FORMAT DELIMITED FIELDS TERMINATED BY ' ' LOCATION 's3://${data.aws_caller_identity.current.account_id}-flow-logs/vpc/${local.name}/AWSLogs/${data.aws_caller_identity.current.account_id}/vpcflowlogs/${local.region}/' TBLPROPERTIES ('skip.header.line.count'='1');"
  description = "Esta declaração SQL deve ser executada na console para criar a tabela. Ela está em 'Saved queries'"
}

# Esta declaração SQL é para ser usada na console para criar as partições
resource "aws_athena_named_query" "vpc_alter_table_vpc_flow_logs" {
  name        = "${local.name}_alter_table_vpc_flow_logs"
  workgroup   = aws_athena_workgroup.vpc.id
  database    = aws_athena_database.vpc.name
  query       = "ALTER TABLE vpc_flow_logs_${local.name} ADD PARTITION (`date`='YYYY-MM-dd') LOCATION 's3://${data.aws_caller_identity.current.account_id}-flow-logs/vpc/${local.name}/AWSLogs/${data.aws_caller_identity.current.account_id}/vpcflowlogs/${local.region}/YYYY/MM/dd';"
  description = "Esta declaração SQL é para ser usada na console para criar as partições. Altere os valores YYYY, MM e dd"
}
