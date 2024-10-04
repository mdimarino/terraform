# cria elastic ip para ser usado pelo nat gateway da vpc
resource "aws_eip" "natgw1_vpc" {

  domain = "vpc"

  tags = {
    Name = "natgw1-${local.name}"
  }
}

# cria a vpc
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name = local.name
  cidr = "10.58.160.0/19"

  azs = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1f"]

  private_subnets     = ["10.58.160.0/22", "10.58.164.0/22", "10.58.168.0/22", "10.58.172.0/22", "10.58.176.0/22"]
  public_subnets      = ["10.58.180.0/24", "10.58.181.0/24", "10.58.182.0/24", "10.58.183.0/24", "10.58.184.0/24"]
  database_subnets    = ["10.58.185.0/24", "10.58.186.0/24", "10.58.187.0/24", "10.58.188.0/24", "10.58.189.0/24"]
  elasticache_subnets = ["10.58.190.0/24", "10.58.191.0/24"]

  enable_ipv6 = false

  # cria 1 (um) NAT GW somente para toda a rede 
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  reuse_nat_ips = true
  external_nat_ip_ids = [
    aws_eip.natgw1_vpc.id
  ]

  enable_flow_log           = true
  flow_log_destination_type = "s3"
  flow_log_destination_arn  = "${module.vpc_flow_logs_bucket.s3_bucket_arn}/vpc/${local.name}/"
  vpc_flow_log_tags = {
    Name = "${local.name}"
  }

  manage_default_network_acl        = true
  public_dedicated_network_acl      = true
  private_dedicated_network_acl     = true
  database_dedicated_network_acl    = true
  elasticache_dedicated_network_acl = true

  default_network_acl_ingress = [
    {
      rule_no    = 100
      action     = "allow"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    },
    {
      rule_no         = 101
      action          = "allow"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      ipv6_cidr_block = "::/0"
    },
  ]

  public_inbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number     = 101
      rule_action     = "allow"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      ipv6_cidr_block = "::/0"
    },
  ]

  public_outbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number     = 101
      rule_action     = "allow"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      ipv6_cidr_block = "::/0"
    },
  ]

  private_inbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number     = 101
      rule_action     = "allow"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      ipv6_cidr_block = "::/0"
    },
  ]

  private_outbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number     = 101
      rule_action     = "allow"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      ipv6_cidr_block = "::/0"
    },
  ]

  database_inbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number     = 101
      rule_action     = "allow"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      ipv6_cidr_block = "::/0"
    },
  ]

  database_outbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number     = 101
      rule_action     = "allow"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      ipv6_cidr_block = "::/0"
    },
  ]

  elasticache_inbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number     = 101
      rule_action     = "allow"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      ipv6_cidr_block = "::/0"
    },
  ]

  elasticache_outbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number     = 101
      rule_action     = "allow"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      ipv6_cidr_block = "::/0"
    },
  ]
}

# cria o grupo de segurança das interfaces (eni) dos vpc endpoints
module "vpc_security_group_vpc_endpoints_interface" {

  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name            = "${local.name}-vpc-endpoints-interface"
  use_name_prefix = false
  description     = "Grupo de seguranca das interfaces dos vpc endpoints"
  vpc_id          = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules       = ["https-443-tcp"]
}

# cria endpoints s3 e dynamodb na vpc
module "vpc_endpoints" {

  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "5.13.0"

  vpc_id = module.vpc.vpc_id

  security_group_ids = [module.vpc_security_group_vpc_endpoints_interface.security_group_id]

  endpoints = {
    s3 = {
      service         = "s3"
      service_type    = "Gateway"
      route_table_ids = flatten([module.vpc.public_route_table_ids, module.vpc.private_route_table_ids])
      tags            = { Name = "${local.name}-s3-vpc-endpoint" }
    },
    dynamodb = {
      service         = "dynamodb"
      service_type    = "Gateway"
      route_table_ids = flatten([module.vpc.public_route_table_ids, module.vpc.private_route_table_ids])
      tags            = { Name = "${local.name}-dynamodb-vpc-endpoint" }
    },
    ecr_api = {
      service             = "ecr.api"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags                = { Name = "${local.name}-ecr-api-vpc-endpoint" }
    },
    ecr_dkr = {
      service             = "ecr.dkr"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags                = { Name = "${local.name}-ecr-dkr-vpc-endpoint" }
    },
    athena = {
      service             = "athena"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags                = { Name = "${local.name}-athena-vpc-endpoint" }
    },
    sqs = {
      service             = "sqs"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags                = { Name = "${local.name}-sqs-vpc-endpoint" }
    },
    sns = {
      service             = "sns"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags                = { Name = "${local.name}-sns-vpc-endpoint" }
    },
  }
}
