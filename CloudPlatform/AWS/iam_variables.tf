variable "github_idp_url" {
  type    = string
  default = "https://token.actions.githubusercontent.com"
}

variable "github_idp_audience" {
  type    = string
  default = "sts.amazonaws.com"
}

variable "github_idp_thumbprints" {
  type    = list(string)
  default = ["6938fd4d98bab03faadb97b34396831e3780aea1", "1c58a3a8518e8759bf075b76b750d4f2df264fcd"]
}

variable "github_allowed_repos" {
  type = list(string)
}
