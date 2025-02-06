variable "eks_cluster_version" {
  type        = string
  description = "Version of EKS to deploy"
}

variable "eks_access" {
  type        = map(list(string))
  description = "EKS policy to user map"
}
