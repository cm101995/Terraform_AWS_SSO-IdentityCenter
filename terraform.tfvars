#sample config
permissions_list = [
    {
        name = "AdministratorAccess"
        description = "adminaccess"
        session_duration = "PT8H"
        managed_policies = ["arn:aws:iam::aws:policy/AdministratorAccess"]
        customer_managed_policies = [{
            name = "Test" #make sure this exists in all accounts you apply to
            path = "/"
        }]
        aws_accounts = ["111111111","222222222222"]
        sso_groups = ["Admin"]
    },
    {
        name = "Developer_Data"
        description = "Permission/policies for Data team"
        session_duration = "PT8H"
        managed_policies = []
        customer_managed_policies = [{
            name = "Data" #make sure this exists in all accounts you apply to
            path = "/"
        }]
        aws_accounts = ["111111111","222222222222"]
        sso_groups = ["Data"]
    }
]
