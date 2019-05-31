# GovWifi Secrets

All secrets are stored in https://github.com/alphagov/govwifi-build, and are encrypted using GPG.

All shell commands assume you are running from within the [`govwifi-terraform`][govwifi-terraform] repository.

## Tools

To use these secrets, you will need the [Password Store][passwordstore] tool installed on your machine.

You will also need an implementation of `gpg` installed. This will be installable under the name `gnupg`:

```
apt/brew/dnf/rpm/yum install gnupg
```

## Getting access

Once you have installed the tools, you will need someone to re-encrypt the secrets with your public key.

Give someone your full key ID:

```sh
gpg --list-keys '<name>@digital.cabinet-office.gov.uk'
```

An example of a key ID is: `06D20CF70AC370DE72F49EDC992939FDD5C5144C`

Please also ensure your public key is on a well known keyserver:

We suggest `hkps.pool.sks-keyservers.net` and `keyserver.ubuntu.com`, as they are known to be reliable.

```sh
gpg --keyserver keyserver.ubuntu.com --send-keys '<your key ID>'
gpg --keyserver hkps.pool.sks-keyservers.net --send-keys '<your key ID>'
```

## Giving Access

Once you have received someone's GPG Key ID, you must receive it, and trust it:

```sh
key_id='<their key ID>'
gpg --keyserver keyserver.ubuntu.com --receive-keys "$key_id"
echo "${key_id}:6" | gpg --import-ownertrust
```

Append the `.private/passwords/.gpg-id` file with their key:

```sh
echo "$key_id" >> '.private/passwords/.gpg-id'
```

then re-encrypt the passwords from within the [`govwifi-terraform`][govwifi-terraform] repo:

```sh
make rencrypt-passwords
```

## Getting a secret

Throughout the documentation, there will be references to specific secrets stored within the password store.

To read individual secrets, run the command:

```sh
PASSWORD_STORE_DIR=.private/passwords pass show '<secret name>'

# example, access the Staging Bastion SSH Key
PASSWORD_STORE_DIR=.private/passwords pass show keys/govwifi-staging-bastion-key
```




[passwordstore]: https://www.passwordstore.org/
[govwifi-terraform]: https://github.com/alphagov/govwifi-terraform
