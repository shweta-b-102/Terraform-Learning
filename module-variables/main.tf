provider "aws" {
    region = "ap-south-1"
  
}

module "ec2-instance" {
    source = "../modules/ec2_instance"
    ami_value = "ami-02ddb77f8f93ca4ca"
    instance_type_value = "t2.micro"  
}