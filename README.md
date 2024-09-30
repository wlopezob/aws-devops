# AWS-DEVOPS
This project focuses on deploying and managing resources on Amazon Web Services (AWS).
## EKS - TERRAFORM
This section outlines the deployment of a private Amazon Elastic Kubernetes Service (EKS) cluster using Terraform. The deployment includes integration with various AWS services for enhanced functionality and accessibility.
### Key Features:
* **Private EKS Cluster:** The EKS cluster will be deployed in a private subnet, enhancing security by restricting direct public access.
* **Ingress Controller - NLB:** An Ingress Controller with a Network Load Balancer (NLB) will be configured to route external traffic to the cluster.
* **API Gateway Integration:**  Amazon API Gateway will be integrated to provide a managed entry point for API requests.
* **VPC Link:** A VPC Link will be established to enable secure communication between the API Gateway and the private EKS cluster.
* **Route 53:** Amazon Route 53 will be utilized for DNS management, allowing you to configure custom domain names for your applications.
* **Custom Domain:** A custom domain will be configured for the API Gateway, providing a user-friendly and memorable URL for accessing your APIs.
### Navigate to EKS Project
For detailed information on the EKS deployment and configuration, please refer to the dedicated folder:
[EKS Project](./eks)