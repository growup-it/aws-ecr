
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.45.0"
    }
  }
  required_version = ">= 1.4.6"
}
provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-4152"
    key            = "terraform/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"  # if you created this for locking
    encrypt        = true
  }
}

data "aws_availability_zones" "available" {}

data "aws_eks_cluster" "cluster" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "cluster" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

locals {
  cluster_name = "learnk8s"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

module "eks-kubeconfig" {
  source       = "hyperbadger/eks-kubeconfig/aws"
  version      = "2.0.0"
  cluster_name = local.cluster_name

  depends_on = [module.eks]
}

resource "local_file" "kubeconfig" {
  content  = module.eks-kubeconfig.kubeconfig
  filename = "kubeconfig_${local.cluster_name}"
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name                 = "k8s-vpc"
  cidr                 = "172.18.0.0/18"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["172.18.1.0/24", "172.18.2.0/24", "172.18.3.0/24"]
  public_subnets       = ["172.18.4.0/24", "172.18.5.0/24", "172.18.6.0/24"]
  enable_nat_gateway   = false
  single_nat_gateway   = false
  enable_dns_hostnames = true
  map_public_ip_on_launch = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.36.0"

  cluster_name    = local.cluster_name
  cluster_version = "1.32"
  subnet_ids      = module.vpc.public_subnets

  vpc_id = module.vpc.vpc_id


  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false

  eks_managed_node_groups = {
    first = {
      desired_capacity = 1
      max_capacity     = 4
      min_capacity     = 1

      instance_type = "t2.micro"
    }
  }
}

resource "aws_ecr_repository" "my_repository" {
  name                 = "my-app-repository" # Replace with your desired repository name
  image_tag_mutability = "MUTABLE"           # Or "IMMUTABLE" depending on your needs
  force_delete         = true                # Enable force deletion of the repository

  tags = {
    Environment = "dev"
    Project     = "my-app"
  }
}

output "repository_url" {
  value       = aws_ecr_repository.my_repository.repository_url
  description = "The URL of the ECR repository"
}

output "cluster_name" {
  value       = module.eks.cluster_name
  description = "The name of the EKS cluster"

}