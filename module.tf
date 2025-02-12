project/modules
   ***ec2***
////main.tf///
provider "aws" {
  alias = "ec2"
  region = var.region
}

resource "aws_instance" "this" {
  provider      = aws.ec2
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}
////output.tf///
output "instance_id" {
  value = aws_instance.this.id
}

output "public_ip" {
  value = aws_instance.this.public_ip
}
/////varibales.tf///
variable "region" {
  description = "AWS region for the EC2 instance"
  type        = string
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}

variable "name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "tags" {
  description = "Tags for the EC2 instance"
  type        = map(string)
  default     = {}
}
project/modules
   ***vpc***
////main.tf///
provider "aws" {
  alias = "vpc"
  region = var.region
}

resource "aws_vpc" "this" {
  provider             = aws.vpc
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}
/////outputs.tf///
output "vpc_id" {
  value = aws_vpc.this.id
}
/////variables.tf////
variable "region" {
  description = "AWS region for the VPC"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "name" {
  description = "Name of the VPC"
  type        = string
}

variable "tags" {
  description = "Tags for the VPC"
  type        = map(string)
  default     = {}
}

project/modules
   ***subnet***
////main.tf///
provider "aws" {
  alias = "subnet"
  region = var.region
}

resource "aws_subnet" "this" {
  provider               = aws.subnet
  vpc_id                 = var.vpc_id
  cidr_block             = var.cidr_block
  availability_zone      = var.availability_zone
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}
///outputs.tf///
output "subnet_id" {
  value = aws_subnet.this.id
}
///variables.tf///
variable "region" {
  description = "AWS region for the Subnet"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
}

variable "map_public_ip_on_launch" {
  description = "Enable public IP on instances in this subnet"
  type        = bool
  default     = false
}

variable "name" {
  description = "Name of the Subnet"
  type        = string
}

variable "tags" {
  description = "Tags for the Subnet"
  type        = map(string)
  default     = {}
}

/////project////
/////main.tf///
module "vpc" {
  source     = "./modules/vpc"
  region     = var.region
  cidr_block = var.vpc_cidr_block
  name       = var.vpc_name
  tags       = { Environment = "dev" }
}

module "subnet" {
  source               = "./modules/subnet"
  region               = var.region
  vpc_id               = module.vpc.vpc_id
  cidr_block           = var.subnet_cidr_block
  availability_zone    = var.subnet_az
  map_public_ip_on_launch = var.subnet_map_public_ip_on_launch
  name                 = "my-subnet"
  tags                 = { Environment = "dev" }
}

module "ec2" {
  source         = "./modules/ec2"
  region         = var.region
  ami            = var.ec2_ami
  instance_type  = var.ec2_instance_type
  subnet_id      = module.subnet.subnet_id
  key_name       = "my-key-pair" # Ensure this matches your AWS key pair
  name           = "my-ec2"
  tags           = { Environment = "dev" }
}
//////outputs.tf///
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_id" {
  value = module.subnet.subnet_id
}

output "instance_id" {
  value = module.ec2.instance_id
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}
/////varables.tf//////
# General AWS Region
variable "region" {
  description = "AWS region to deploy the infrastructure"
  type        = string
  default     = "us-east-1" # Change as needed
}

# VPC Variables
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
  default     = "my-vpc"
}

# Subnet Variables
variable "subnet_cidr_block" {
  description = "CIDR block for the Subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_az" {
  description = "Availability zone for the Subnet"
  type        = string
  default     = "us-east-1a"
}

variable "subnet_map_public_ip_on_launch" {
  description = "Whether to map public IPs on instance launch"
  type        = bool
  default     = true
}

# EC2 Variables
variable "ec2_ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI
}

variable "ec2_instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "ec2_key_name" {
  description = "Key pair name for SSH access"
  type        = string
  default     = "my-key-pair" # Update with your key pair
}
///command for key////
aws ec2 create-key-pair --key-name my-key-pair --query "KeyMaterial" --output text > my-key-pair.pem
chmod 400 my-key-pair.pem 
ssh-keygen -y -f my-key-pair.pem > my-key-pair.pub



  
