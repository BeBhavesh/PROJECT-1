# IAM ROLE (EKS)
resource "aws_iam_role" "eks_role" {
  name = "${var.project}-eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
      Action   = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_cluster" "eks" {
  name     = "${var.project}-eks"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.public_1.id,
      aws_subnet.public_2.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.eks_policy]
}

# NODE ROLE
resource "aws_iam_role" "node_role" {
  name = "${var.project}-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action   = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "node_policies" {
  for_each = toset([
    "AmazonEKSWorkerNodePolicy",
    "AmazonEKS_CNI_Policy",
    "AmazonEC2ContainerRegistryReadOnly"
  ])

  role       = aws_iam_role.node_role.name
  policy_arn = "arn:aws:iam::aws:policy/${each.value}"
}

resource "aws_eks_node_group" "nodes" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "default-nodes"
  node_role_arn  = aws_iam_role.node_role.arn
  subnet_ids     = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
}
