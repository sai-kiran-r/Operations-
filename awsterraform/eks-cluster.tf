#
# EKS Cluster Resources 
# * EKS Cluster
#

resource "aws_eks_cluster" "sai" {
    name = "${var.cluster-name}"
    role_arn = "${aws_iam_role.sai-cluster.arn}"

    vpc_config {
        security_group_ids = ["${aws_security_group.sai-cluster.id}"] 
        subnet_ids = aws_subnet.sai.*.id
    }
    depends_on = [ 
        "aws_iam_role_policy_attachment.sai-cluster-AmazonEKSClusterPolicy", 
        "aws_iam_role_policy_attachment.sai-cluster-AmazonEKSServicePolicy",
    ] 
}