# GovWifi Quiz

The purpose of this quiz is to allow a new developer of GovWifi to be able to get up and running using the various applications which interact with each other.

## Setup

#### Connect to the production read replica sessions database

- We logged in to govwifi AWS account via gds-users. Production is in London, DR in Ireland. Found a DB called wifi-production-user-rr, noting the subnets.

- Decided we should be able to access the DB via one of the EC2 instances in the same subnets.

- Found out we could access the DB via the Wifi Bastion instance, using the primary user’s SSH key which is encrypted (using GNU pass) in alphagov/govwifi-build.

- We got the DB credentials from the same password store under secrets-to-copy/terraform/wifi-london/secrets.auto.tfvars.

- We found the command for connecting to the DB is in the ubuntu user’s bash history on the Bastion box. Then we used the password from the previous step. The command was something like this, since the DB has a route53 entry:

`mysql -h users-rr.<govwifi domain> -u <user>`

####  Remove Kyle Chapman and Adrian Clay’s gpg keys from the system and re-encrypt the secrets. Instruct the GovWifi team on what to do after this is done.

- We did a  [github search for “adrian”](https://github.com/alphagov/govwifi-build/search?q=adrian&unscoped_q=adrian)  and “kyle”.

- `grep`'d for their names across the govwifi repos.

- We found a  [joiner/leaver checklist](https://github.com/alphagov/govwifi-build/blob/master/docs/joiner-leaver-checklist.md). This raised some questions that we asked the govwifi team:
  – Were the AWS accounts for these users created manually?  **Yes**
  – Do we rotate secrets after removing users?  **No**

- We removed Adrian from  `govwifi-build/terraform/<env>/userlist.tf`

- We manually deleted Kyle’s AWS account (last activity 73 days ago)

- We removed Adrian and Kyle’s GPG key IDs from  `govwifi-build/passwords/.gpg-id`

- Rafal re-encrypted the secrets on a branch and I tested that I could decrypt them:  [https://github.com/alphagov/govwifi-build/pull/348](https://github.com/alphagov/govwifi-build/pull/348)


## Terraform & Build

####  Run terraform against staging and production for London and Dublin and see that no changes need to be applied.

- Working in  [alphagov/govwifi-build](https://github.com/alphagov/govwifi-build)  and replacing  `staging-london`  with the environment being applied:

- Whoever is deploying will need to be able to decrypt secrets in the password store and will need to be logged in with AWS (using  `aws-vault`  for example)

- Rotate the Notify API key on STAGING (eg: Notify API key has been compromised)

- Log into notify  [https://www.notifications.service.gov.uk](https://www.notifications.service.gov.uk/)

- Generate new key

- Run:

- Replace the  `notify-api-key`  value with the new key

- Apply all the terraforms

- Log into notify  [https://www.notifications.service.gov.uk](https://www.notifications.service.gov.uk/)  and revoke old key


## Concourse

#### Spin up a new pipeline for a feature branch. Then remove it.

- Run:

	`fly login -t cd-govwifi -n govwifi -c https://cd.gds-reliability.engineering
	 fly -t cd-govwifi set-pipeline --pipeline <pipeline name>-new --config <path to pipeline yaml>`

#### Apply a new pipeline config to an existing pipeline

- Same as above but use the existing pipeline name.

- There are self-updating pipelines now, so merging a pipeline change to master should deploy it.

## RADIUS

#### Confirm on one of the STAGING frontend RADIUS servers that the IP address 12.23.23.12 is whitelisted within the config.

- Run:
  `aws s3 cp s3://govwifi-staging-admin/ips-and-locations.json - | grep -o 12.23.23.12 `
  and make sure you see the IP.

## Disaster Recovery

#### The frontends (FreeRADIUS) didn’t restart last night, how would you go about debugging this?

- The infra runs as ECS tasks, so we can go into ECS, pick the  _wifi-frontend_  cluster (for production), and look at the logs for the  _frontend-service-wifi_  task.

- The frontend servers are restarted daily by the  _wifi-daily-safe-restart_  CloudWatch event. The task this runs is configured to log to the  _wifi-safe-restart-docker-log-group_CloudWatch log group so we should look there for issues.

#### Restore an RDS backup for the user database and connect to it from your local machine

- We’d go into the RDS snapshots section and pick the one we want to restore. Connecting to the database is as described above.

## Support

#### Many users at location “Stafford Crown Court” are complaining about not being able to connect to GovWifi. Find out why. (Production)

- These might be some useful CloudWatch logs to look at:
  – wifi-logging-api-docker-log-group
  – wifi-authorisation-api-docker-log-group

The Battersea Dogs & Cats Home wants to offer GovWifi in their building but their organisation name doesn’t appear in the list. Please allow them to signup, (STAGING). The network admin’s email is  [mrs.jones@battersea.org.uk](mailto:mrs.jones@battersea.org.uk).

## Performance Platform

#### The data for Signups by Channel for April 20th 2019 looks incorrect. Please resubmit it. (production)

- Data is in the  _wifi-london-pp-data_  bucket. I think it gets there via the horrific inlined bash script in the Bastion EC2 instance  _user_data_  in  `govwifi-terraform/govwifi-backend/management.tf`.
