
# Data sources for AWS resources
data "aws_availability_zones" "available" {}

## Data source for the current AWS region
data "aws_region" "current" {}

# Data source for the current AWS account
data "aws_caller_identity" "current" {}

# data source for EKS cluster and authentication
data "aws_eks_cluster" "cluster" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

# data source for EKS cluster authentication
data "aws_eks_cluster_auth" "cluster" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}
