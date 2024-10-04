#### VPC ####
variable "region" {
  description = "The region to deploy the resources"
  type        = string
}
variable "project_name_prefix" {
  type        = string
  description = "the prefix of the project name"
}
variable "cidr_block-vpc" {
  type        = string
  description = "The CIDR block for the VPC"
}
variable "cidr_block-sb-public01" {
  type        = string
  description = "The CIDR block for subnet public 01"
}
variable "cidr_block-sb-private01" {
  type        = string
  description = "The CIDR block for subnet private 01"
}
variable "cidr_block-sb-private02" {
  type        = string
  description = "The CIDR block for subnet private 02"
}
variable "az-public01" {
  type        = string
  description = "The AZ public 01"
}
variable "az-private01" {
  type        = string
  description = "The AZ private 01"
}
variable "az-private02" {
  type        = string
  description = "The AZ private 02"
}
variable "name-az-public01" {
  type        = string
  description = "The AZ's name public 01"
}
variable "name-az-private01" {
  type        = string
  description = "The AZ's name private 01"
}
variable "name-az-private02" {
  type        = string
  description = "The AZ's name private 02"
}

#### EKS ####
variable "role_arn_cluster" {
  type        = string
  description = "arm role for eks cluster"
}
variable "cluster_version" {
  type        = string
  description = "The version of the EKS cluster"
}
variable "instance_type" {
  type        = string
  description = "The instance type for nodes in the EKS cluster"
}
variable "node_count" {
  type        = number
  description = "The number of nodes in the EKS cluster"
}
variable "namespace" {
  type        = string
  description = "The namespace for the EKS cluster"
}