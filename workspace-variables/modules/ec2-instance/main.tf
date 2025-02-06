provider "aws" {
    region = "ap-south-1"
}

variable "ami" {
    description = "this is ami id of the instance"
  
}

variable "instance_type" {
    description = "This is instance type of the machine"
  
}

resource "aws_instance" "myec2" {
    ami = var.ami
    instance_type = var.instance_type
  
}
