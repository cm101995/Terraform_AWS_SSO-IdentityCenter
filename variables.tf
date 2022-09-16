variable "region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "MENTION_YOUR_REGION_HERE"
}

variable "permissions_list" {
  type = list(object({
    name             = string
    description      = string
    session_duration = string
    managed_policies = list(string)
    customer_managed_policies = list(object({
      name = string
      path = string
    }))
    aws_accounts     = list(string)
    sso_groups       = list(string)
  }))
  description = "List of permission set properties"
}
