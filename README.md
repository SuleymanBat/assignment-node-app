# ASSIGNMNET-NODE-HOSTNAME

This repository contains a CI/CD pipeline for deploying a Docker image to a Kubernetes cluster using Helm.

## Prerequisites
Docker must be installed on the build machine.
kubectl must be installed on the build machine.
Helm must be installed on the build machine.
An Amazon Web Services (AWS) account is required.
The AWS CLI must be installed on the build machine.
An AWS Elastic Container Registry (ECR) must be set up.
A Kubernetes cluster must be set up and configured with kubectl.

## Configuration
The following secrets must be configured in the repository settings:

AWS_ACCESS_KEY: The access key for the AWS account.

AWS_SECRET_ACCESS_KEY: The secret access key for the AWS account.

AWS_SSH_KEY_PRIVATE: The private key for the SSH key pair used to access the EC2 instances.

AWS_SSH_KEY_PUBLIC: The public key for the SSH key pair used to access the EC2 instances.

REGISTRY: The URL of the AWS ECR registry.

REPOSITORY: The name of the repository in the ECR registry.

IMAGE_TAG: The tag to be used for the Docker image.

KUBE_CONFIG: The base64-encoded kubeconfig file for the Kubernetes cluster.

## CI/CD Pipeline
The pipeline is triggered on pushes to the master branch and pull requests.

The pipeline consists of the following jobs:

### setup
This job checks out the repository and generates variables for the repository name and git tag.

### docker
This job builds and pushes the Docker image to the ECR registry.

### deploy
This job deploys the Docker image to the Kubernetes cluster using Helm.

## Deployment
To deploy the application, push commits to the master branch or create a pull request. The pipeline will automatically build, push, and deploy the Docker image to the Kubernetes cluster.

## Customization
The deployment process can be customized by modifying the values.yaml file. This file contains variables that are passed to the Helm chart during deployment.

## Monitoring
The status of the pipeline can be monitored in the Actions tab of the repository. The deployment can be monitored by checking the status of the pods and services in the Kubernetes cluster using kubectl.

## Troubleshooting
If the pipeline fails, the error message and log output can be checked in the Actions tab of the repository.

## Contributions
Contributions to this repository are welcome. Please follow the standard Git workflow (fork, clone, create a branch, make changes, commit, push, and create a pull request).

## License
This project is licensed under the MIT License.

# USED COMMANDS WHILE CREATING EKS CLUSTER AND DEPLOYMENT OF HELM CHARTS

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

sudo usermod -aG docker $USER

sudo docker build -t suleyman-assign-repo:latest .

aws ecr create-repository --repository-name suleyman-assign-repo

ECR URL

890927215245.dkr.ecr.us-east-1.amazonaws.com/suleyman-assign-repo

docker build -t suleyman-assign-repo:ingress .

docker tag suleyman-assign-repo 890927215245.dkr.ecr.us-east-1.amazonaws.com/suleyman-assign-repo:ingress

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 890927215245.dkr.ecr.us-east-1.amazonaws.com

docker push 890927215245.dkr.ecr.us-east-1.amazonaws.com/suleyman-assign-repo:ingress

helm install assignment bitnami/node


