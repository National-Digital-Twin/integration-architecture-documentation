variable "resource_prefix" {
  type        = string
  description = "Resource prefix"
}

variable "vpce_name" {
  type        = string
  description = "VPCe service name"
}

variable "vpce_type" {
  type        = string
  default     = "Interface"
  description = "To be used as the routable alias in the service's R53 hosted zone"
}

variable "record_type" {
  type    = string
  default = "A"
}

variable "endpoint_subnets" {
  type        = list(string)
  description = "Subnets to be associated with the VPCe"
}

variable "vpc_ids" {
  type        = list(string)
  description = "VPC's which will be able to resolve the R53 hosted zone"
}

variable "vpc_id" {
  type        = string
  description = "VPC which the vpce will be reside"
}

variable "sg_allowed_cidrs" {
  type        = list(string)
  description = "Network cidr's that will be able to route to the VPCe"
}

variable "sg_ingress_port" {
  type        = number
  default     = 443
  description = "Default port for sg ingress"
}

variable "use_vpce_custom_policy" {
  type        = bool
  default     = false
  description = "VPCe custom policy switch"
}

variable "vpce_custom_policy" {
  type        = string
  default     = ""
  description = "Custom JSON policy for VPCe"
}

variable "shared_vpce_service_name" {
  type        = string
  default     = null
  description = "Name of VPCe service that has been shared with AWS via allowed principles"
}

variable "private_dns_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable private DNS"
}

variable "global_service" {
  type        = bool
  default     = false
  description = "VPCe which has a global service name (not regional)"
}
