# Adding new AWS users

You can add new AWS users to the govwifi AWS accounts by:

1. first verifying with the govwifi developers whether to grant `admin` or `read-only`
   access.

1. Add the user with the appropriate privileges to the terraform file [here][tech-ops-private-site]. You need to get the pull request approved and merged by reliability engineering.

1. Deploy the terraform changes by:

     a. go to the govwifi account terraform directory of repository [tech-ops-private][tech-ops-private]:

     ```sh
     cd terraform/deployments/re-govwifi/account/
     ```

     b. using [gds-cli][gds-cli], initialise terraform if
     you have not done so previously:

     ```sh
     gds aws govwifi -- terraform init
     ```

     c. plan the terraform project to make sure the changes are what you intend to deploy:

     ```sh
     gds aws govwifi -- terraform plan
     ```
     
     d. apply the terraform changes if you are happy to proceed:

     ```sh
     gds aws govwifi -- terraform apply
     ```

[gds-cli]: https://github.com/alphagov/gds-cli
[tech-ops-private-site]: https://github.com/alphagov/tech-ops-private/blob/master/reliability-engineering/terraform/deployments/re-govwifi/account/site.tf
[tech-ops-private-site]: https://github.com/alphagov/tech-ops-private
