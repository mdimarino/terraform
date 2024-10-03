module "vpc_security_group_private" {

  create = false

  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name            = "${local.name}-private"
  use_name_prefix = false
  description     = "grupo de seguranca de teste"
  vpc_id          = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["all-all"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  egress_ipv6_cidr_blocks = []
}

module "vpc_ec2_instance_private" {

  create = false

  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.0"

  name = "${local.name}-private"

  instance_type          = "t3a.nano"
  vpc_security_group_ids = [module.vpc_security_group_private.security_group_id]
  subnet_id              = element(module.vpc.private_subnets, 2)

  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      # throughput  = 200
      # volume_size = 50
      # tags = {
      #   Name = "network-hub-egress-prod"
      # }
    },
  ]

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
}

module "vpc_security_group_public" {

  create = false

  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name            = "${local.name}-public"
  use_name_prefix = false
  description     = "grupo de seguranca de teste"
  vpc_id          = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules       = ["ssh-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  egress_ipv6_cidr_blocks = []
}

module "vpc_ec2_instance_public" {

  create = false

  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.0"

  name = "${local.name}-public"

  instance_type          = "t3a.nano"
  vpc_security_group_ids = [module.vpc_security_group_public.security_group_id]
  subnet_id              = element(module.vpc.public_subnets, 2)

  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      # throughput  = 200
      # volume_size = 50
      # tags = {
      #   Name = "network-hub-egress-prod"
      # }
    },
  ]

  associate_public_ip_address = true

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
}
