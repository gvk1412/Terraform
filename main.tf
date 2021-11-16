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
  access_key = "AKIAX37KI4XVDF3P4LNU"
  secret_key = "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"

}
resource "aws_instance" "terraform-1" {
  ami= "ami-0f1fb91a596abf28d"
  instance_type = "t3.micro"
  tags={
      Name="tf-1"
  }  
}

