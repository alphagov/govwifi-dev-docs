# Accessing the Infrastructure

## Overview

An overview of the infrastructure is shown below ![arch-diagram][arch-diagram]

## Adding new AWS users

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

## AWS Console

Access is via [gds-users](https://gds-users.signin.aws.amazon.com/console), and then assuming your role from the GovWifi account.

Staging and Production are hosted within the same AWS account.

The GovWifi Account ID is `788375279931` and your role is in the form `firstname.lastname-admin` or `firstname.lastname-readonly`.

## VPN

All connections must be made via the GDS VPN. Please contact your local service desk for access.

## Bastions

The bastion servers act as a gateway to their respective clusters + databases.
That is to say:

- To access any Staging database or server, you must access via the staging bastion.
- To access any Production database or server, you must access via the production bastion.

### Accessing the Bastion

#### Secrets

[Extract the SSH Key secrets][getting-a-secret] for the bastion server:

- staging secret name: `keys/govwifi-staging-bastion-key`
- production secret name: `keys/govwifi-bastion-key`

Find out the Elastic IPs for the bastion servers. You can do this by going into the AWS console,
and find the instances with the Bastion name in.

Remember that there are 2 regions, so there may be more than 2 bastions.

#### SSH Config

It is recommended to set up an ssh config for ease of use. Instructions how to
set up your SSH config is in the Password Store of Govwifi where you can run:

```sh
PASSWORD_STORE_DIR=<password_store_dir> pass show ssh/instructions.txt
```

where `<password_store_dir>` is the path of the `passwords` directory of the
[govwifi-build](https://github.com/alphagov/govwifi-build) repository on your
local machine.

You should now be able to connect to each of the hosts using ssh. For e.g.

```sh
ssh govwifi-bastion-london-staging
```

## Databases

There are 10 databases in total:

### Production

- Admin, MySQL 5.7
  - Primary in London
- Sessions, MySQL 5.7
  - Primary in London
  - Replica in London
- Users, MySQL 8.0
  - Primary in London
  - Replica in London
  - Replica in Dublin

### Staging

- Admin, MySQL 5.7
  - Primary in London
- Sessions, MySQL 5.7
  - Primary in London
- Users, MySQL 8.0
  - Primary in London
  - Replica in Dublin

To access each one, you will need to use their respective credentials and bastion server.

### Admin database

This database provides for the Admin portal, storing organisation details.

**AWS Naming convention**: Used for finding the database in the AWS Console

- Production: `wifi-admin-wifi-db`
- Staging: `wifi-admin-staging-db`

Connect to the admin database:

**Endpoint**: View in the AWS Console

**Username**: View in the AWS Console, or the terraform config.

- Production: `grep 'admin-db-username' '.private/non-encrypted/secrets-to-copy/govwifi/wifi-london/variables.auto.tfvars'`
- Staging: `grep 'admin-db-username' '.private/non-encrypted/secrets-to-copy/govwifi/staging-london/variables.auto.tfvars'`

**Password**: Get the password from the [encrypted terraform secrets][getting-a-secret]:

- Production: `PASSWORD_STORE_DIR=.private/passwords pass show secrets-to-copy/govwifi/wifi-london/secrets.auto.tfvars | grep admin-db-password`
- Staging: `PASSWORD_STORE_DIR=.private/passwords pass show secrets-to-copy/govwifi/staging-london/secrets.auto.tfvars | grep admin-db-password`

Use your favourite GUI, or set up an SSH tunnel.

### Users database

This database provides for the authentication service, for storing user credentials and login activity.

**AWS Naming convention**: Used for finding the database in the AWS Console

- Production: `wifi-production-user-db` and `wifi-production-user-rr`
- Staging: `wifi-staging-user-db` and `wifi-staging-user-rr`

**Endpoint**: View in the AWS Console.

**Username**: View in the AWS Console, or [the terraform config][getting-a-secret].

- Production: `PASSWORD_STORE_DIR=.private/passwords pass show secrets-to-copy/govwifi/wifi-london/secrets.auto.tfvars  | grep -e "^user-db-username"`
- Staging: `PASSWORD_STORE_DIR=.private/passwords pass show secrets-to-copy/govwifi/staging-london/secrets.auto.tfvars  | grep -e "^user-db-username"`

**Password**: Get the password from the [encrypted terraform secrets][getting-a-secret]:

- Production: `PASSWORD_STORE_DIR=.private/passwords pass show secrets-to-copy/govwifi/wifi-london/secrets.auto.tfvars  | grep -e "^user-db-password"`
- Staging: `PASSWORD_STORE_DIR=.private/passwords pass show secrets-to-copy/govwifi/wifi-london/secrets.auto.tfvars  | grep -e "^user-db-password"`

Use your favourite GUI, or set up an SSH tunnel.

### Sessions database

This database provides for the logging service, for tracking user sessions.

**AWS Naming convention**: Used for finding the database in the AWS Console

- Production: `wifi-wifi-db` and `wifi-db-rr`
- Staging: `wifi-staging-db`

**Endpoint**: View in the AWS Console.

**Username**: View in the AWS Console, or [the terraform config][getting-a-secret].

- Production: `PASSWORD_STORE_DIR=.private/passwords pass show secrets-to-copy/govwifi/wifi-london/secrets.auto.tfvars  | grep -e "^db-user"`
- Staging: `PASSWORD_STORE_DIR=.private/passwords pass show secrets-to-copy/govwifi/staging-london/secrets.auto.tfvars  | grep -e "^db-user"`

**Password**: Get the password from the [encrypted terraform secrets][getting-a-secret]:

- Production: `PASSWORD_STORE_DIR=.private/passwords pass show secrets-to-copy/govwifi/wifi-london/secrets.auto.tfvars  | grep -e "^db-password"`
- Staging: `PASSWORD_STORE_DIR=.private/passwords pass show secrets-to-copy/govwifi/wifi-london/secrets.auto.tfvars  | grep -e "^db-password"`

Use your favourite GUI, or set up an SSH tunnel.

[arch-diagram]: /images/govwifi_architecture_diagram.png "Govwifi Architecture Diagram"
[getting-a-secret]: /secrets.html#Getting-a-secret
[gds-cli]: https://github.com/alphagov/gds-cli
[tech-ops-private-site]: https://github.com/alphagov/tech-ops-private/blob/master/reliability-engineering/terraform/deployments/re-govwifi/account/site.tf
[tech-ops-private-site]: https://github.com/alphagov/tech-ops-private
