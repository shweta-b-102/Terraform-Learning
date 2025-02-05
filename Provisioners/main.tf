provider "aws" {
    region = "ap-south-1"
}
   

variable "cidr_block" {
    default = "10.0.0.0/16"
   
}

    resource "aws_vpc" "shweta-cloud" {
        cidr_block = var.cidr_block
}

    resource "aws_internet_gateway" "igw" {
      vpc_id = aws_vpc.shweta-cloud.id
   
 }
    
    resource "aws_subnet" "Public-subnet" {
    vpc_id     = aws_vpc.shweta-cloud.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"

    tags = {
    Name = "public-subnet"
  }
}

   resource "aws_route_table" "Public-RT" {
   vpc_id = aws_vpc.shweta-cloud.id

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  
} 

    resource "aws_route_table_association" "RT-subnet-aws_route_table_association" {
    subnet_id      = aws_subnet.Public-subnet.id
    route_table_id = aws_route_table.Public-RT.id
}
    
   resource "aws_security_group" "webSg" {
   name   = "web"
   vpc_id = aws_vpc.shweta-cloud.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-sg"
  }
}  
    resource "aws_key_pair" "deployer" {
    key_name   = "deployer-key"
    public_key = file("C:/Users/hp/.ssh/id_rsa.pub")
 }
    resource "aws_instance" "server" {
        ami = "ami-00bb6a80f01f03502"
        instance_type = "t2.micro"
        key_name = aws_key_pair.deployer.key_name
        vpc_security_group_ids = [aws_security_group.webSg.id]
        subnet_id = aws_subnet.Public-subnet.id
        associate_public_ip_address = true


       connection {
       type     = "ssh"
       user     = "ubuntu"
       private_key = file("C:/Users/hp/.ssh/id_rsa")
       host     = self.public_ip
  }
      provisioner "file" {
      source      = "app.py"
      destination = "/home/ubuntu/app.py"
}    

      provisioner "remote-exec" {
      inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",  # Update package lists (for ubuntu)
      "sudo apt-get install -y python3-pip",  # Example package installation
      "cd /home/ubuntu",
      "sudo pip3 install flask",
      "sudo python3 app.py &",
    ]
  }
}
    


    
 

    


