module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.24.3"

  cluster_name    = local.name
  cluster_version = "1.30"

  cluster_endpoint_public_access = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  cluster_service_ipv4_cidr =  "172.21.0.0/16"

  # EKS Addons
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id = "vpc-01814125c7e1442a2"
  subnet_ids = [
    "subnet-037f07705450c3f3c",
    "subnet-089a98dbd73428fb7",
    "subnet-0b740aaa0c9435b5d",
    "subnet-01ca2d551e97f9636",
    "subnet-068f5d23a94bf4447"
  ]

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t3a.small", "t3a.medium", "t3.small", "t3.medium"]
  }

  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  eks_managed_node_groups = {
    ng_base = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      instance_types = ["t3a.medium", "t3.medium"]
      capacity_type  = "SPOT"

      min_size = 2
      max_size = 5
      # This value is ignored after the initial creation
      # https://github.com/bryantbiggs/eks-desired-size-hack
      desired_size = 2
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  tags = local.tags
}

module "fargate_profile" {
  source = "terraform-aws-modules/eks/aws//modules/fargate-profile"
  version = "20.24.3"

  name         = "fargate-kube-system"
  cluster_name = module.eks.cluster_name

  subnet_ids = [
  "subnet-037f07705450c3f3c",
  "subnet-089a98dbd73428fb7",
  "subnet-0b740aaa0c9435b5d",
  "subnet-01ca2d551e97f9636",
  "subnet-068f5d23a94bf4447"
  ]

  selectors = [{
    namespace = "kube-system"
  }]
}