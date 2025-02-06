variable "cognito_access" {
  type        = map(list(string))
  description = "Cognito group to Cognito user mapping"
}
