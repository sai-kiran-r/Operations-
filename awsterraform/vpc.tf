# VPC Resources
# *VPC
# * Subnets
# * Internet Gateway # * Route Table
#

resource "aws_vpc" "sai" { 
    cidr_block = "10.0.0.0/16"

    tags = "${ 
        tomap({
        "Name" = "terraform-eks-sai-node",
        "kubernetes.io/cluster/${var.cluster-name}" = "shared", 
        })
    }" 
}

resource "aws_subnet" "sai" { 
    count = 2

    availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
    cidr_block = "10.0.${count.index}.0/24"
    vpc_id = "${aws_vpc.sai.id}"

    tags = "${
        tomap({
            "Name" = "terraform-eks-sai-node",
            "kubernetes.io/cluster/${var.cluster-name}" = "shared",
        })
    }"
}

resource "aws_internet_gateway" "sai" { 
    vpc_id = "${aws_vpc.sai.id}"
    tags = {
        Name = "terraform-eks-sai"
    } 
}

resource "aws_route_table" "sai" { 
    vpc_id = "${aws_vpc.sai.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.sai.id}"
    } 
}

resource "aws_route_table_association" "sai" { 
    count = 2
    subnet_id = "${aws_subnet.sai.*.id[count.index]}" 
    route_table_id = "${aws_route_table.sai.id}"
}