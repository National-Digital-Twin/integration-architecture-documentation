data "aws_eks_cluster_auth" "ianode" {
  name = module.eks_ianode.cluster_name
}
