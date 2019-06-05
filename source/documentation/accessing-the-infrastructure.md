# Accessing the Infrastructure

## AWS Console

The GovWifi Account ID is `788375279931`.

This can be used for logging into the console, or for assumed roles.

Use `https://788375279931.signin.aws.amazon.com/console` or `https://govwifi.signin.aws.amazon.com/console` for
accessing the AWS console.

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

There are 4 databases, all currently located in London. 2 for staging, 2 for production.

To access each one, you will need to use their respective credentials and bastion server.

### Admin database

**AWS Naming convention**: Used for finding the database in the AWS Console

- Production: `wifi-admin-wifi-db`
- Staging: `wifi-admin-staging-db`

For anything related to the Admin panel, connect to the admin database:

**Endpoint**: View in the AWS Console

**Username**: View in the AWS Console, or the terraform config.

- Production: `grep 'admin-db-username' '.private/non-encrypted/secrets-to-copy/govwifi/wifi-london/variables.auto.tfvars'`
- Staging: `grep 'admin-db-username' '.private/non-encrypted/secrets-to-copy/govwifi/staging-london/variables.auto.tfvars'`

**Password**: Get the password from the [encrypted terraform secrets][getting-a-secret]:

- Production secret name: `PASSWORD_STORE_DIR=.private/passwords pass show govwifi/wifi-london/secrets.tf | grep admin-db-password`
- Staging: `PASSWORD_STORE_DIR=.private/passwords pass show govwifi/staging-london/secrets.tf | grep admin-db-password`

Use your favourite GUI, or set up an SSH tunnel.

### Wifi database

**AWS Naming convention**: Used for finding the database in the AWS Console

- Production: `wifi-wifi-db`
- Staging: `wifi-staging-db`

This database provides for the authentication, logging, and user signup.

**Endpoint**: View in the AWS Console.

**Username**: View in the AWS Console, or [the terraform config][getting-a-secret].

- Production: `PASSWORD_STORE_DIR=.private/passwords pass show  govwifi/wifi-london/secrets.tf | grep -e "^db-user"`
- Staging: `PASSWORD_STORE_DIR=.private/passwords pass show  govwifi/staging-london/secrets.tf | grep -e "^db-user"`

**Password**: Get the password from the [encrypted terraform secrets][getting-a-secret]:

- Production: `PASSWORD_STORE_DIR=.private/passwords pass show govwifi/wifi-london/secrets.tf | grep -e "^db-password"`
- Staging: `PASSWORD_STORE_DIR=.private/passwords pass show govwifi/staging-london/secrets.tf | grep -e "^db-password"`

Use your favourite GUI, or set up an SSH tunnel.

[getting-a-secret]: ./secrets.md#Getting-a-secret
