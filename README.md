1. Install eksctl : https://eksctl.io/installation/#direct-download-latest-release-amd64x86_64-armv6-armv7-arm64
    unzip and add binary to env_variables


2. Create Cluster : eksctl create cluster --name Kubernetes-demo --region us-west-2 --node-type t3.micro

3. Check cluster info : eksctl get cluster --region us-east-1

  cluster_name = "learnk8s"
  cluster_name = "learnk8s"
aws eks update-kubeconfig --name learnk8s --region ap-south-1


eksctl create cluster \
  --name my-cluster \
  --region us-west-2 \
  --with-oidc


  Ref: https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/
  https://dev.to/aws-builders/securely-access-amazon-eks-with-github-actions-and-openid-connect-2im2

