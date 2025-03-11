# VPC DEFAULT VARIABLES
variable "vpc" {
  description = "Details about the VPC."
  type        = map(string)
}

# TAGS
variable "tag" {
  description = "Details about the VPC."
  type        = map(string)
}

variable "client" {
  description = "Client Tags for resources"
  type        = string
}
variable "environment" {
  description = "Env Tags for resources"
  type        = string
}

# SUBNETS DETAILS
variable "priv-subnets" {
  description = "list of values to assign to subnets"
  type = map(object({
    name              = string
    address_prefix    = string
    availability_zone = string
  }))
}

variable "pub-subnets" {
  description = "list of values to assign to subnets"
  type = map(object({
    name              = string
    address_prefix    = string
    availability_zone = string
  }))
}