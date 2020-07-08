# Joiners & Leavers

This should be a complete list of tools/services that new technology team
joiners should be given access to, and leavers be removed from.


## Joiners checklist

### Try it out!

1. [Sign up to GovWifi!](https://www.wifi.service.gov.uk/about-govwifi/connect-to-govwifi/)
2. Ask your tech lead to add you to the [Admin Portal](https://admin.wifi.service.gov.uk/) and [Admin Portal - Staging](https://admin.staging.wifi.service.gov.uk/)

### Infrastructure

1. [Request an AWS account](https://gds-request-an-aws-account.cloudapps.digital/).
2. Ask RE-GovWifi (#re-govwifi on slack) to add you to GovWifi account(s) - process is described [here][adding_new_aws_users]
3. [Set up your access to the infrastructure][accessing-the-infrastructure] - includes access to databases and ssh.
4. We use GovPaaS in some places. See [Gov.uk Platform as a Service - Get started](https://docs.cloud.service.gov.uk/get_started.html). Once you have an account, ask your Tech Lead to add you to the `govwifi` organization.

### Secrets

See [secrets][secrets] for getting access to shared secrets, certificates and keys. Someone on your team will need to add you.

### Development and deployment

- Ask your Tech Lead to add you to the [alphagov organisation](https://github.com/alphagov) and [GovWifi team](https://github.com/orgs/alphagov/teams/govwifi).
- The main GovWifi repositories are listed under [the application overview][application]. Just follow the instructions on the repository.
- We use [Concourse](https://cd.gds-reliability.engineering/) for deployment - it uses GitHub OAuth. See [Deploying][deploying] to learn how we use it.

To understand how all fits together, [check the Service Operation Manual](https://docs.google.com/document/d/1XvzfnjQf2kCbArJBiI6B6_pnvZOCkwX-N1WyTPAZfWI/edit).

### Monitoring and support

- Alerts and logs can be found on [Cloudwatch](https://eu-west-2.console.aws.amazon.com/cloudwatch/home?region=eu-west-2#).
- [Sentry SaaS](https://sentry.io/organizations/government-digital-services/projects/) uses a shared password, see [secrets][secrets].
- [Zendesk ticketing system](https://govuk.zendesk.com/agent/dashboard)
    - create a ticket (or ask your Tech Lead) to be added to "GovWifi queues" and assign it to `2nd/3rd Line -- Zendesk Administration`
    - see [Zendesk Summary][support_zendesk] for triaging and common requests.


### Other bits and bobs

- Trello [GovWifi](https://trello.com/govwifi) team
- [Notify](https://www.notifications.service.gov.uk/accounts)
  - GovWifi
  - GovWifi-Staging
- Google groups, current list of groups:
  - GovWifi Team
  - GovWifi-Critical-Alerts
  - GovWifi-DevOps
  - GovWifi-Feedback
  - govwifi-support


## Leavers checklist

Open a "Leavers ticket" with Estates and IT, and remove them from everything under Joiners checklist.

In particular:

- you may still need to remove them from teams, even if they use GitHub/Google OAuth.
- make sure to remove any personal GPG keys from [secrets][secrets] and SSH keys from infrastructure, when they exist.
- all shared secrets should live under [secrets][secrets].

## Deprecated

For completeness, the following accounts exist but are not being used. They use a shared account.

* [Hund.io](https://status.wifi.service.gov.uk/dashboard/team/users)
* [Status.io](https://manage.statuspage.io/organizations/p6bxj7rb8tpc/team)
* [Firetex](https://app.firetext.co.uk/)

[adding_new_aws_users]: /adding_new_aws_users.html
[application]: /index.html
[accessing-the-infrastructure]: /accessing-the-infrastructure.html
[deploying]: /deploying.html
[secrets]: /secrets.html
[support_zendesk]: /support_zendesk.html
