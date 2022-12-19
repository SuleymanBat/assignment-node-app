
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"


# CREATING eks cluster
eksctl create cluster \
 --name suleyman-assignment \
 --region us-east-1 \
 --zones us-east-1a,us-east-1b,us-east-1c \
 --nodegroup-name my-nodes \
 --node-type t2.medium \
 --nodes 2 \
 --nodes-min 2 \
 --nodes-max 3 \
 --ssh-access \
 --ssh-public-key  ~/.ssh/id_rsa.pub \
 --managed


aws eks list-clusters --output=json
aws eks --region us-east-1 update-kubeconfig --name suleyman-cluster-assignment

# Installing HELM
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh


helm show values bitnami/node > values.yaml


aws ecr create-repository --repository-name suleyman-assign-repo

# ECR URL
## 890927215245.dkr.ecr.us-east-1.amazonaws.com/suleyman-assign-repo

docker tag suleyman-assign-repo 890927215245.dkr.ecr.us-east-1.amazonaws.com/suleyman-assign-repo:latest


aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 890927215245.dkr.ecr.us-east-1.amazonaws.com


docker push 890927215245.dkr.ecr.us-east-1.amazonaws.com/suleyman-assign-repo:latest

helm install assignment bitnami/node
# assignment-node-app
