
module "eks_managed_node_group" {
  source               = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  cluster_service_cidr = module.eks.cluster_service_cidr
  name                 = local.cluster_name
  cluster_name         = module.eks.cluster_name
  cluster_version      = local.cluster_version


  subnet_ids                        = module.vpc.private_subnets
  cluster_primary_security_group_id = module.eks.cluster_primary_security_group_id
  vpc_security_group_ids            = [module.eks.node_security_group_id]
  min_size                          = 2
  max_size                          = 3
  desired_size                      = 2

  instance_types = ["t2.medium"]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}