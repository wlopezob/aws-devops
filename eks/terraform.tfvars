region                  = "us-west-2"
project_name_prefix     = "wlopezob"

### VPC ###
cidr_block-vpc          = "172.16.0.0/16"
cidr_block-sb-public01  = "172.16.1.0/24"
cidr_block-sb-private01 = "172.16.2.0/24"
cidr_block-sb-private02 = "172.16.3.0/24"
az-public01             = "us-west-2a"
name-az-public01        = "public-2a"
az-private01            = "us-west-2b"
az-private02            = "us-west-2c"
name-az-private01       = "private-2b"
name-az-private02       = "private-2c"

### EKS ###
role_arn_cluster        = "arn:aws:iam::031745324447:role/eksClusterRoleWlopezob"
cluster_version         = "1.30"
instance_type           = "t3.medium"
node_count              = 1
namespace               = "wlopezob"