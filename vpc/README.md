## AWS

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


# EKS

### get kubeconfig
```
aws eks update-kubeconfig --region us-west-2  --name wlopezob-eks-cluster
```

### execute kubectl with kubeconfig
```
kubectl --kubeconfig=kubeconfig
```


### alias
```
alias k=kubectl
alias ku="kubectl -n wlopezob"
alias ki="kubectl -n ingress"
alias tf=terraform
alias h=helm
```

### create tmp pod
```
kubectl -n wlopezob run nginx --image=nginx --restart=Never --rm -it -- sh
apt update
apt install curl
```



