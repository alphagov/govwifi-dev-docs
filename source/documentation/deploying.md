# Deploying

Deploying 9 systems out at the same time can be a non-trivial task. This should
help explain how we do it.

## Concourse

Deploying GovWifi is done via Concourse, [hosted by GDS][gds_concourse].

You will need to be part of the GovWifi team, and logged in.

## Core Services

For the core services, there is a [central deployment pipeline][concourse_deploy_pipeline].

The code is hosted in the [pipeline repo][concourse_deploy_pipeline_repo]

This covers the:

- Admin portal
- Authentication API
- Logging API
- User Signup API
- Frontend RADIUS
- Safe 'Canary' Restarter

The general process is:

- Run tests
- Deploy Staging
- Wait for user to allow Production deploy
- Deploy Production

Each service is deployed independently.

To ensure interoperability between the services, we run Cross-Service tests for the Frontend, and APIs.
This ensures that an update to a service will work between the rest of the services.

### Triggering a deployment

- Push to the master branch
- Concourse will test, build and deploy to the Staging environments
- Run the job in the pipeline, titled `Confirm Deploy to <service> Production`
- Concourse will deploy to the Production environments

## Docs and the Product Page

The [Dev Docs][dev-docs-repo], [Tech Docs][tech-docs-repo], and [Product Page][product-page-repo] each have their
own pipelines located in their repos.

They deploy out to [GovPaaS][govpaas] whenever a change is made to the `master` branch of each repo.

### Triggering a deployment

- Push to the master branch
- Concourse will build + deploy to GovPaaS
- Verify contents is deployed (you may need to add a `GET` parameter to bust the cache) 


[gds_concourse]: https://cd.gds-reliability.engineering/
[concourse_deploy_pipeline]: https://cd.gds-reliability.engineering/teams/govwifi/pipelines/deploy
[concourse_deploy_pipeline_repo]: https://github.com/alphagov/govwifi-concourse-deploy-pipeline
[dev-docs-repo]: https://github.com/alphagov/govwifi-dev-docs
[tech-docs-repo]: https://github.com/alphagov/govwifi-tech-docs
[product-page-repo]: https://github.com/alphagov/govwifi-product-page
[govpaas]: https://www.cloud.service.gov.uk/
