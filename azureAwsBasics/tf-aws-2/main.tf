provider "aws" {
    region = "us-east-1" 
}

resource "aws_instance" "myweb" {
    ami = "ami-09d069a04349dc3cb"
    instance_type = "t2.micro"
    security_groups = ["${aws_security_group.tenable.name}"]
    key_name = "midnight"

    tags = {
        Name = "myweb"
    } 
}

resource "aws_security_group" "tenable" {
    name = "tenable-scanner-sai"
    description = "Web Security Group"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp" 
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 5000
        to_port = 5000
        protocol = "tcp" 
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

