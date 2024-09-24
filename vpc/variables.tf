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
variable "az-public01" {
  type        = string
  description = "The AZ public 01"
}
variable "az-private01" {
  type        = string
  description = "The AZ private 01"
}
variable "name-az-public01" {
  type        = string
  description = "The AZ's name public 01"
}
variable "name-az-private01" {
  type        = string
  description = "The AZ's name private 01"
}