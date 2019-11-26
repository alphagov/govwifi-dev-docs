# Team Dashboard

We now have dashboards!

We currently display dashboards on our TV monitors (two of them), running on ChromeOS. This section 
outlines what's currently displayed on them.

## Technical

The top monitor has technical dashboards worth keeping an eye on throughout the day.

### Grafana

Grafana is an open source analytics and monitoring platform, and we use it for monitoring the health 
of GovWifi in realtime.

GovWifi has its own organisation, and we have admin-level access so we can now make our own changes 
without having to always involve RE. 

We currently have two dashboards in Grafana, which are both shown on the TV monitor:

1. The first is for monitoring performance of GovWifi Product Pages and Tech Docs, and is available
[here](https://grafana-paas.cloudapps.digital/d/KMxSG3DWk/govwifi).

2. The second is for monitoring GovWifi's SLIs for authentication journeys, as well as success rates
for SMS and email responses, and is available
[here](https://grafana-paas.cloudapps.digital/d/THPLfGxWk/govwifi-cloudwatch).
    
    Grafana currently gets these metrics from AWS CloudWatch. In order to grant Grafana access to
    these, we are using an access key generated for the `monitor` IAM user in our AWS account.

### Concourse

Concourse is an open source CI/CD platform, and we use it for automating jobs for building, testing 
and deploying software, as part of pipelines.

Most of GovWifi's core pipelines are exposed (i.e. public, but read-only and without logs). These 
are available [here](https://cd.gds-reliability.engineering/?search=team%3A%20govwifi), and are 
shown on the TV monitor.

It is useful to keep an eye on these, so that blocked pipelines can be spotted early and resolved.

### Fourth Wall

Fourth Wall is a GDS application for monitoring pull requests and their build statuses.

We list all of our repositories on Fourth Wall on the TV monitor, as it helps in identifying 
important and urgent pull requests that should be prioritised.

In order for Fourth Wall to make calls to Github's APIs, we're using a personal access token
generated for our `github-jenkins` Github user.

### Google Analytics

We currently have a tab with default Google Analytics dashboard open. This will be iterated over 
to make it more useful in the near future.

## General

The bottom monitor has general team-specific things, mostly for meetings and ceremonies.

### Google Calendar

Our TV monitor has its own Google account, and is a member of the "GovWifi core team" Google Group.
This means it should already be included in most, if not all, existing team meetings. If an event
does not show up in its calendar but should, please invite it separately.

### Google Meet

This dashboard provides a convenient list of upcoming meetings to join throughout the day.

### Trello

Our TV monitor has its own Trello account (`@gds9097chromebox`), and has guest read-only access to 
our team's boards.
