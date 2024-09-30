# 01-vpc.tf
This Terraform file defines the core networking infrastructure for your AWS environment. It creates:
- **A Virtual Private Cloud (VPC):** This is the isolated network environment where your resources will reside.
- **Public Subnet:** A subnet within the VPC that is publicly accessible, typically used for resources like load balancers and web servers.
- **Private Subnet:** A subnet within the VPC that is not publicly accessible, typically used for resources like databases and application servers.
## Resources
### `aws_vpc`
- **`vpc-main`:** Creates the main VPC with the specified CIDR block.
- **`cidr_block`:** Defines the IP address range for the VPC (defined in `variables.tf`).
- **`enable_dns_support`:** Enables DNS resolution within the VPC.
- **`enable_dns_hostnames`:** Allows instances to be addressed by their hostnames.
- **`tags`:** Applies tags to the VPC for identification and organization (uses a project name prefix defined in `variables.tf`).
### `aws_subnet`
- **`sb-public-01`:** Creates a public subnet in the specified availability zone.
- **`vpc_id`:** Associates the subnet with the main VPC.
- **`cidr_block`:** Defines the IP address range for the subnet (defined in `variables.tf`).
- **`availability_zone`:** Specifies the availability zone for the subnet (defined in `variables.tf`).
- **`enable_resource_name_dns_a_record_on_launch`:** Automatically creates DNS records for instances launched in the subnet.
- **`map_public_ip_on_launch`:** Assigns public IP addresses to instances launched in the subnet.
- **`tags`:** Applies tags to the subnet for identification (uses a project name prefix and availability zone name defined in `variables.tf`).
- **`sb-private-01`:** Creates a private subnet in the specified availability zone.
- **`vpc_id`:** Associates the subnet with the main VPC.
- **`cidr_block`:** Defines the IP address range for the subnet (defined in `variables.tf`).
- **`availability_zone`:** Specifies the availability zone for the subnet (defined in `variables.tf`).
- **`tags`:** Applies tags to the subnet for identification (uses a project name prefix and availability zone name defined in `variables.tf`).
## Variables
This file uses variables defined in `variables.tf` for customization. These include:
- `cidr_block-vpc`: The CIDR block for the VPC.
- `cidr_block-sb-public01`: The CIDR block for the public subnet.
- `cidr_block-sb-private01`: The CIDR block for the private subnet.
- `az-public01`: The availability zone for the public subnet.
- `az-private01`: The availability zone for the private subnet.
- `name-az-public01`: The name of the public availability zone.
- `name-az-private01`: The name of the private availability zone.
- `project_name_prefix`: A prefix used for resource naming.
## Usage
This file is intended to be used as part of a larger Terraform project. It should be applied after the `variables.tf` file has been defined. 
## Note
- Ensure that the variables in `variables.tf` are configured according to your environment's requirements.
- This file defines a basic VPC structure. You may need to modify it to accommodate more complex networking needs.


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



