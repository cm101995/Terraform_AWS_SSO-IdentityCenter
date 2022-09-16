# Terraform_AWS_SSO-IdentityCenter

Prerequisites:
1) Version 4.30. This version only supports Customer_managed_policies. This was a feature introduced last month. They have changed the name from SSO to Identity center.
2) Make sure customer managed policies exist in all the account you attach it to.

This repo will help you to manage your SSO/Identity center as Infrastructure as code.

1)Replace the profile and region in the main.tf/other files.
2)You can import the existing resources(account assignment,customer managed policy and managed policy) using the below commands:
 
  terraform import 'aws_ssoadmin_account_assignment.assignment["PERMISSIONSETNAME.ACCOUNTID.GROUPNAME"]' 1234z1z1-z000-0000-0000-000000zz0z00,GROUP,111111111111,AWS_ACCOUNT,arn:aws:sso:::permissionSet/ssoins-000000zzzz1zzzzzz/ps-00z0z000z00z0z0z,arn:aws:sso:::instance/ssoins-00000zzzz1zzzzzz
  
  terraform import 'aws_ssoadmin_customer_managed_policy_attachment.cmp["PERMISSIONSETNAME.CUSTOMERPOLICYNAME.PATH"]' TEST,/,arn:aws:sso:::permissionSet/ssoins-000000zzzz1zzzzzz/ps-00z0z000z00z0z0z,arn:aws:sso:::instance/ssoins-00000zzzz1zzzzzz

  terraform import 'aws_ssoadmin_managed_policy_attachment.managed_policy["MANAGEDPOLICYNAME.PERMISSIONNAME"]' arn:aws:iam::aws:policy/AdministratorAccess,arn:aws:sso:::permissionSet/ssoins-000000zzzz1zzzzzz/ps-00z0z000z00z0z0z,arn:aws:sso:::instance/ssoins-00000zzzz1zzzzzz
  
3)terraform plan to check if you missed any existing resources.

4)You can make use of terraform.tfvars to create new permission sets.
