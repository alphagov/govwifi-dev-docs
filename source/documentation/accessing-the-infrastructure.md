# Accessing the Infrastructure

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

It is recommended to set up an ssh config for ease of use. All further instructions will
assume you use similar naming.

**Note**: The IP addresses have been redacted. Please substitute in the correct IP addresses.

```
AddKeysToAgent = yes

Host govwifi-bastion-london-staging <redacted IP address>
    Hostname <redacted IP address>
    User ubuntu
    IdentityFile ~/.ssh/govwifi/bastion-staging

Host govwifi-bastion-london-production <redacted IP address>
    Hostname <redacted IP address>
    User ubuntu
    IdentityFile ~/.ssh/govwifi/bastion-production

Host govwifi-bastion-ireland-production <redacted IP address>
    Hostname <redacted IP address>
    User ubuntu
    IdentityFile ~/.ssh/govwifi/bastion-production
```

You should now be able to connect to each of the hosts using ssh.

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

[getting-a-secret]: /secrets.html#Getting-a-secret
