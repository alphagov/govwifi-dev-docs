# Govwifi developer documentation

This is the technical documentation for the [Govwifi](https://www.wifi.service.gov.uk/) team in the [Government Digital Service (GDS)](https://gds.blog.gov.uk/). For other projects built by GDS, see the [Service Toolkit](https://www.gov.uk/service-toolkit).

## Applications overview

Our public-facing websites are:

- A [product page](https://github.com/alphagov/govwifi-product-page) explaining the benefits of GovWifi
- An [admin platform](https://github.com/alphagov/govwifi-admin) for organiations to self-serve changes to their GovWifi installation
- [Technical documentation](https://github.com/alphagov/govwifi-tech-docs), explaining GovWifi in more detail
- A [redirection service](https://github.com/alphagov/govwifi-redirect) to handle "www" requests to these sites

Our services include:
- [Frontend servers](https://github.com/alphagov/govwifi-frontend), instances of freeRADIUS that act as authentication servers

- An [authentication API](https://github.com/alphagov/govwifi-authentication-api), which the frontend calls to help authenticate GovWifi requests
- A [logging API](https://github.com/alphagov/govwifi-logging-api), which the frontend calls to record each GovWifi request
- A [user signup API](https://github.com/alphagov/govwifi-user-signup-api), which handles incoming sign-up texts and e-mails (with a little help from AWS)

We manage our infrastructure via:

- Terraform, see [govwifi-terraform](https://github.com/alphagov/govwifi-terraform)
- The [safe restarter](https://github.com/alphagov/govwifi-safe-restarter), which uses a [CanaryRelease](https://martinfowler.com/bliki/CanaryRelease.html) strategy to increase the stability of the frontends

Other repositories:

- [Acceptance tests](https://github.com/alphagov/govwifi-acceptance-tests), which pulls together GovWifi end-to-end, from the various repositories, and runs tests against it.


## Get started developing with Govwifi applications

Govwifi applications are written in [Ruby](https://www.ruby-lang.org/en/) using either [Rails](https://rubyonrails.org/) and [Sinatra](http://sinatrarb.com/) web frameworks.


To get started you'll need Ruby installed on your system. We recommend using a Ruby version manager like [rbenv](https://github.com/rbenv/rbenv) which will allow you to install the correct version of Ruby for Govwifi projects.


### Building a development / test environment

Each Govwifi application Github repository contains a [README](https://github.com/alphagov/govwifi-admin/blob/master/README.md) detailing how to build a development environment for running tests and making local changes.

Most of the projects use a combination of [Make](https://www.gnu.org/software/make/), [Docker](https://www.docker.com/) and [docker-compose](https://docs.docker.com/compose/) to create the necessary containers and seed data for a local development environment.


### Bug and feature workflow

Please read the [GDS Git styleguide](https://github.com/alphagov/styleguides/blob/master/git.md) which details how your code commits should be structured.

Once you're happy with your changes locally, submit a pull request, if possible include a reference in the description to the original details (eg. a link to the Trello story), explain what the pull request does, include screenshots if applicable.

Pull requests are linted and tests are run on [Concourse CI](https://cd.gds-reliability.engineering/teams/govwifi/pipelines/admin-pr), the resulting status is shown on the PR.

Once everything is green on CI, you can ask a team member to review your PR.


### Merging and deploying changes

Once approved and merged your PR is automatically built and deployed to our staging environment where you can perform further acceptance testing. After that deploying to production is a manual step in Concourse CI.


