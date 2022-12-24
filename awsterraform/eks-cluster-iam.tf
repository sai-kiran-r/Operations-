#
# EKS Cluster Resources
# * IAM Role to allow EKS service to manage other AWS services #


resource "aws_iam_role" "sai-cluster" { 
    name = "terraform-eks-sai-cluster"
    assume_role_policy = <<POLICY
    {

    "Version": "2012-10-17", 
    "Statement": [
        {
        "Effect": "Allow", 
        "Principal": {
        "Service": "eks.amazonaws.com" 
        },
        "Action": "sts:AssumeRole" 
        }
    ]
}
POLICY 
}
resource "aws_iam_role_policy_attachment" "sai-cluster-AmazonEKSClusterPolicy" { 
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role = "${aws_iam_role.sai-cluster.name}"
}
resource "aws_iam_role_policy_attachment" "sai-cluster-AmazonEKSServicePolicy" { 
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
    role = "${aws_iam_role.sai-cluster.name}"
}
