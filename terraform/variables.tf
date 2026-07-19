variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "travelmemory"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"
}

variable "aws_region" {
  description = "Target AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t2.micro"
}

# Ubuntu 22.04 AMI (Override from terraform.tfvars if required)
variable "ubuntu_ami" {
  description = "Ubuntu 22.04 LTS AMI ID"
  type        = string
  default     = ""
}

variable "allowed_ssh_ip" {
  description = "IP address allowed to connect via SSH"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
  default     = ""
}