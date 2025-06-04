locals {
  cluster_name    = "learnk8s"
  cluster_version = "1.33"
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

module "eks" {
  source                                   = "terraform-aws-modules/eks/aws"
  version                                  = "~> 20.36.0"
  cluster_name                             = local.cluster_name
  cluster_version                          = local.cluster_version
  cluster_endpoint_public_access           = true
  cluster_endpoint_private_access          = true
  cluster_endpoint_public_access_cidrs     = ["0.0.0.0/0"]
  enable_cluster_creator_admin_permissions = true
  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

# EKS Addons
  cluster_addons = {
    coredns                = {
      most_recent = true
    }
    eks-pod-identity-agent = {
      most_recent = true
    }
    kube-proxy             = {
      most_recent = true
    }
    vpc-cni                = {
      most_recent = true
    }
  }

  cluster_upgrade_policy = {
    support_type = "STANDARD"
  }
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

resource "aws_ecr_repository" "my_repository" {
  name                 = "my-app-repository" # Replace with your desired repository name
  image_tag_mutability = "MUTABLE"           # Or "IMMUTABLE" depending on your needs
  force_delete         = true                # Enable force deletion of the repository

  tags = {
    Environment = "dev"
    Terraform   = "true"
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