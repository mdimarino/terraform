module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.24.3"

  cluster_name    = local.name
  cluster_version = "1.29"

  cluster_endpoint_public_access = true

  # EKS Addons
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id = "vpc-0b72643f02c3971ae"
  subnet_ids = [
    "subnet-055f4494bfe555e07",
    "subnet-055fb526e5c15c6a4",
    "subnet-0ab4021c49cc9faf1",
    "subnet-0ae339964871e53f4",
    "subnet-0c3f4c351a6ec8913"
  ]

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t3a.small", "t3a.medium", "t3.small", "t3.medium"]
  }

  eks_managed_node_groups = {
    example = {
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