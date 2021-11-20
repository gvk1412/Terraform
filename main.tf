#terraform providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
  
}
# aws resources
resource "aws_instance" "terraform-1" {
  count = 2
  ami= "ami-0f1fb91a596abf28d"
  instance_type = "t3.micro"
  tags={
      Name="tf ${count.index}"
  }  
}
# aws vpc 
resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "my_vpc"
  }
}
# aws subnet 
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "my_vpc"
  }
}
# data source 
data "aws_vpc" "devault_vpc" {
  default = true
}
# variables on below cider block
variable "subnet_cider_block" {
    description = "subnet cider block"
  
}
#assigning sub net to default vpc/existing vpc / and adding tags for replication envi terraform-dev.tfvars
variable "tags" {
  description = "tag name for subnet"

}
resource "aws_subnet" "default_subnet" {
  vpc_id = data.aws_vpc.devault_vpc.id
  cidr_block = var.subnet_cider_block
  tags ={
    Name = var.tags 
  }
}
# Output to display the values in terminal 
output "mysubnetid" {
  value = aws_subnet.default_subnet.id  
}
output "myvpcid" {
  value = aws_vpc.my_vpc.id  
}
