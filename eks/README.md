# 01-vpc.tf
## Description
This Terraform file defines the core networking infrastructure for the project, including:
- **Virtual Private Cloud (VPC)**: Provides an isolated network environment within AWS.
- **Subnets**: Segment the VPC into public and private networks for different resources.
- **Route Tables**: Control traffic flow between subnets and to the internet.
- **Internet Gateway**: Enables internet connectivity for the public subnet.
- **NAT Gateway**: Allows private resources to access the internet without being directly exposed.
## Resources Defined
### `aws_vpc`
Creates a VPC with a specified CIDR block and enables DNS support.
- **vpc-main**: The main VPC for the project.
### `aws_subnet`
Defines subnets within the VPC, categorized into public and private.
- **sb-public-01**: Public subnet for internet-facing resources.
- **sb-private-01**: Private subnet for internal resources.
- **sb-private-02**: Second private subnet in a different availability zone for redundancy.
### `aws_internet_gateway`
Creates an internet gateway to connect the VPC to the internet.
- **igw**: The internet gateway for the project.
### `aws_nat_gateway`
Creates a NAT gateway to enable internet access for private resources.
- **nat**: The NAT gateway associated with the public subnet.
### `aws_route_table`
Defines routing rules for network traffic.
- **rt-public**: Route table for the public subnet, directing traffic to the internet gateway.
- **rt-private**: Route table for the private subnet, routing traffic through the NAT gateway for internet access.
### `aws_route_table_association`
Associates subnets with their respective route tables.
- **rta-public-01**: Connects the public subnet to the public route table.
- **rta-private-01**: Connects the first private subnet to the private route table.
- **rta-private-02**: Connects the second private subnet to the private route table.
## Variables
The file uses variables defined in `variables.tf` to customize the infrastructure configuration. These variables allow for flexibility in deploying the infrastructure across different environments and regions.
## Note
- Ensure that the variables in `variables.tf` are configured according to your environment's requirements.
- This file defines a basic VPC structure. You may need to modify it to accommodate more complex networking needs.

# 02-eks.tf
## Description
This Terraform file defines the resources necessary to provision an Amazon Elastic Kubernetes Service (EKS) cluster within the Virtual Private Cloud (VPC) created in `01-vpc.tf`. It includes the following components:
- **EKS Cluster**: The core Kubernetes cluster that manages worker nodes and applications.
- **Node Group**: A set of EC2 instances that form the worker nodes of the cluster.
- **IAM Roles and Policies**: Necessary permissions for EKS and worker nodes to interact with AWS services.
- **Security Group**: Controls network access to the worker nodes.
## Resources Defined
### `aws_eks_cluster`
Creates an EKS cluster with the specified configuration, including version, role ARN, and VPC settings.
- **cluster**: The main EKS cluster for the project.
### `aws_eks_node_group`
Defines a node group within the EKS cluster, specifying instance types, desired capacity, and subnets for worker nodes.
- **nodegroup**: The node group for the cluster, containing worker nodes.
### `aws_iam_role`
Creates IAM roles for the EKS cluster and worker nodes.
- **eks-cluster-role**: Role for the EKS cluster to interact with AWS services.
- **eks-node-role**: Role for worker nodes to access AWS resources.
### `aws_iam_role_policy_attachment`
Attaches necessary policies to the IAM roles.
- **AmazonEKSClusterPolicy**: Provides permissions for the EKS cluster to manage resources.
- **AmazonEKSWorkerNodePolicy**: Grants worker nodes access to necessary AWS services.
- **AmazonEKS_CNI_Policy**: Enables the use of the Amazon VPC CNI plugin for networking.
- **AmazonEC2ContainerRegistryReadOnly**: Allows worker nodes to pull images from ECR.
## Variables
The file uses variables defined in `variables.tf` to customize the EKS cluster configuration, such as cluster version, instance type, node count, and namespace.
## Note
- Ensure that the variables in `variables.tf` are configured according to your environment's requirements.
- This file defines a basic EKS cluster setup. You may need to modify it for more advanced configurations, such as using Fargate profiles or custom AMIs.
- Remember to configure `kubectl` to access the cluster after creation.

# Other commands
### aws configure
```
aws configure
```
### aws validate account
```
aws sts get-caller-identity
```
## Terraform
### start terraform
```
terraform init
```

### update providers
```
terraform init -upgrade
```

### create the plan
```
terraform plan -out main.tfplan
```

### execute the plan
```
terraform apply "main.tfplan"
```

### create the plan destroy
```
terraform plan -destroy -out main.destroy.tfplan
```

### execute the plan destroy
```
terraform apply main.destroy.tfplan
```


## EKS

### get kubeconfig
```
aws eks update-kubeconfig --region us-west-2  --name wlopezob-eks-cluster
```

### execute kubectl with kubeconfig
```
kubectl --kubeconfig=kubeconfig
```


## alias
```
alias k=kubectl
alias ku="kubectl -n wlopezob"
alias ki="kubectl -n ingress"
alias tf=terraform
alias h=helm
```

## create tmp pod
```
kubectl -n wlopezob run nginx --image=nginx --restart=Never --rm -it -- sh
apt update
apt install curl
```


