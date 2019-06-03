# Setting up Terraform

Govwifi infrastructure is managed using [Terraform](https://www.terraform.io/) which is configured via [govwifi-terraform](https://github.com/alphagov/govwifi-terraform).

### Prerequisites

There are several prerequisites to running [govwifi-terraform](https://github.com/alphagov/govwifi-terraform) `make` commands successfully:

- Your GPG key ID has been added to [govwifi-build](https://github.com/alphagov/govwifi-build/blob/master/passwords/.gpg-id) and secrets in this project have been re-encrypted.
- You have an AWS IAM user with the ability to assume a suitable role (RE:D team can set this up).
- Your AWS configuration contains an appropriate profile wth the suitable role.
  eg.

  ```
  [profile govwifi]
  region = eu-west-1
  role_arn=arn:aws:iam::1234567890:role/your.name
  mfa_serial=arn:aws:iam::1234567890:mfa/your.name@digital.cabinet-office.gov.uk
  ```

- You've installed Terraform version `0.11.14`, this can easily be installed alongside other versions using [tfenv](https://github.com/tfutils/tfenv).
- (Optional) [aws-vault](https://github.com/99designs/aws-vault) is a useful AWS credential management tool. If you have other AWS credentials on you system this may help switch profiles.


### Running Terraform for the first time

If you are running terraform commands for the first time you'll need to initialise terraform, this involves decrypting secrets and getting the backend state from S3. This is handled by one make command:

```
aws-vault exec govwifi -- make <env> init-backend
```
(use a staging env when testing your setup).

After this you should be able to run `plan` to verify everything works:

```
aws-vault exec govwifi -- make <env> plan
```

You should see the confirmation message:

```
No changes. Infrastructure is up-to-date.
```

You're now ready to make some changes!
