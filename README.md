1. Install eksctl : https://eksctl.io/installation/#direct-download-latest-release-amd64x86_64-armv6-armv7-arm64
    unzip and add binary to env_variables


2. Create Cluster : eksctl create cluster --name Kubernetes-demo --region us-west-2 --node-type t3.micro with-oidc

3. Check cluster info : eksctl get cluster --region us-east-1


eksctl create cluster \
  --name my-cluster \
  --region us-west-2 \
  --with-oidc