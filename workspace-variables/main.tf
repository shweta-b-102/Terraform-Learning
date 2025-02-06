provider "aws" {
    region = "ap-south-1"
  
}

variable "ami" {
    description = "The ami value description"
  
}

variable "instance_type" {
    description = "value"
    type = map(string)

    default = {
      "default" = "t2.micro"
      "dev"     = "t2.medium"
      "stage"   = "t2.micro"
    }
}

module "ec2-instance" {
    source = "./modules/ec2-instance"
    ami = var.ami
    instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
  
}
