variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_name" {
  type    = string
  default = "bank_vpc"
}

variable "vpc_cidr" {
  type    = string
  default = "172.20.0.0/20"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_classiclink" {
  description = "Should be true to enable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic."
  type        = bool
  default     = null
}

variable "enable_classiclink_dns_support" {
  description = "Should be true to enable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
  type        = bool
  default     = null
}

variable "enable_ipv6" {
  description = "Requests an Amazon-provided IPv6 CIDR block."
  type        = bool
  default     = false
}

variable "vpc_environment" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = "Development"
}

# Public Subnets
variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["172.20.1.0/24", "172.20.2.0/24"]
}

variable "public_subnet_azs" {
  description = "List of Availability Zones for public subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# Private Subnets
variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = ["172.20.3.0/24", "172.20.4.0/24", "172.20.5.0/24", "172.20.6.0/24"]
}

variable "private_subnet_azs" {
  description = "List of Availability Zones for private subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1a", "us-east-1b"]
}

variable "aws_s3_bucket" {
  type    = string
  default = "banks3-terraform-bucket-20250203"
}

variable "my_ip" {
  type    = string
  default = "154.161.249.41"
}


variable "bastion_ami" {
  description = "AMI ID for the Bastion Host (Amazon Linux 2 recommended)"
  type        = string
  default     = "ami-0f214d1b3d031dc53"
}

variable "bastion_instance_type" {
  description = "Instance type for the Bastion Host"
  type        = string
  default     = "t3.micro"
}

variable "tomcat_ami" {
  description = "AMI ID for the Tomcat instance (Amazon Ubuntu Server 24.04 LTS)"
  type        = string
  default     = "ami-04b4f1a9cf54c11d0"
}

variable "tomcat_instance_type" {
  description = "Instance type for the Tomcat Host"
  type        = string
  default     = "t3.micro"
}
variable "key_name" {
  description = "SSH Key Name for accessing the our instances"
  type        = string
  default     = "bank_key"
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  default     = "app-alb"
}

variable "target_group_name" {
  description = "Name of the Target Group for EC2 instances"
  type        = string
  default     = "app-target-group"
}
