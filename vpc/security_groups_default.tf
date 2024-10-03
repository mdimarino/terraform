module "vpc_security_group_default_container" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name            = "default-container"
  use_name_prefix = false
  description     = "Grupo de seguranca padrao para containers da vpc"
  vpc_id          = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      description = "aplicacoes na porta 3000 tcp"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules       = ["http-80-tcp", "http-8080-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  egress_ipv6_cidr_blocks = []
}

module "vpc_security_group_default_ec2" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name            = "default-ec2"
  use_name_prefix = false
  description     = "Grupo de seguranca padrao para instancias ec2 da vpc"
  vpc_id          = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      description = "aplicacoes na porta 3000 tcp"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules       = ["http-80-tcp", "http-8080-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  egress_ipv6_cidr_blocks = []
}

module "vpc_security_group_default_private_alb" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name            = "default-private-alb"
  use_name_prefix = false
  description     = "Grupo de seguranca padrao para ALBs privados da vpc"
  vpc_id          = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      description = "aplicacoes na porta 3000 tcp"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules       = ["http-80-tcp", "http-8080-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  egress_ipv6_cidr_blocks = []
}

module "vpc_security_group_default_public_alb" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name            = "default-public-alb"
  use_name_prefix = false
  description     = "Grupo de seguranca padrao para ALBs publicos da vpc"
  vpc_id          = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      description = "aplicacoes na porta 3000 tcp"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules       = ["http-80-tcp", "http-8080-tcp", "https-443-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  egress_ipv6_cidr_blocks = []
}

module "vpc_security_group_default_msk" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name            = "default-msk"
  use_name_prefix = false
  description     = "Grupo de seguranca padrao para clusters MSK (Kafka) da vpc"
  vpc_id          = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules       = ["kafka-broker-tcp", "kafka-broker-tls-tcp", "kafka-broker-sasl-scram-tcp", "kafka-broker-sasl-iam-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  egress_ipv6_cidr_blocks = []
}

module "vpc_security_group_default_lambda" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name            = "default-lambda"
  use_name_prefix = false
  description     = "Grupo de seguranca padrao para funcoes lambda da vpc"
  vpc_id          = module.vpc.vpc_id

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  egress_ipv6_cidr_blocks = []
}

module "vpc_security_group_default_database" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name            = "default-database"
  use_name_prefix = false
  description     = "Grupo de seguranca padrao para bases de dados da vpc"
  vpc_id          = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules       = ["mysql-tcp", "postgresql-tcp", "redis-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  egress_ipv6_cidr_blocks = []
}
