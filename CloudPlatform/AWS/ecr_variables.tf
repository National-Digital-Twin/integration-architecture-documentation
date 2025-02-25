variable "ecr_repo_names" {
  type        = list(string)
  description = "ECR repoistory names"
  default     = ["ianode-access", "secure-agent-graph", "federator-server", "federator-client"]
}
