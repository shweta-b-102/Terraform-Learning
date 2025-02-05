locals {
  instance_type = {
  default = "t2.nano"
  dev = "t2.medium"
  prod = "t2.nano"  
}
}

resource "aws_instance" "myec2" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = local.instance_type[terraform.workspace]
  
}
