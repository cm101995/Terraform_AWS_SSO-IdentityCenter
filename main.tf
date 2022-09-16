terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.30"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "MENTION_YOUR_REGION_HERE"
  profile = "MENTION_YOUR_PROFILE_HERE"
}

resource "aws_ssoadmin_permission_set" "permset" {
  for_each = {
    for permission in var.permissions_list :
    permission.name => permission
  }
  instance_arn     = local.sso_instance_arn
  name             = each.value.name
  description      = each.value.description
  session_duration = each.value.session_duration
}

resource "aws_ssoadmin_managed_policy_attachment" "managed_policy" {
  for_each           = local.managed_policy_arns
  instance_arn       = local.sso_instance_arn
  managed_policy_arn = each.value.policy_arn
  permission_set_arn = aws_ssoadmin_permission_set.permset[each.value.permission_set_name].arn
}

resource "aws_ssoadmin_account_assignment" "assignment" {
  for_each           = local.account_group_assignments
  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.permset[each.value.permission_set_name].arn
  principal_id       = data.aws_identitystore_group.id_group[each.value.group].id
  target_id          = each.value.account
  principal_type     = "GROUP"
  target_type        = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_customer_managed_policy_attachment" "cmp" {
  for_each           = local.customer_managed_policy_arns
  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.permset[each.value.permission_set_name].arn
  customer_managed_policy_reference {
    name = each.value.policy_name
    path = each.value.policy_path
  }
}
