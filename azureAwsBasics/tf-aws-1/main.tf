resource "aws_instance" "my-test-instance-sai" { 
    ami = "${data.aws_ami.ubuntu.id}" 
    instance_type = "t2.micro"
tags = {
    Name = "test-instance-sai"
    } 
}