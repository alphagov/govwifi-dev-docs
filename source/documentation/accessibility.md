# Accessibility 

## Upgrading GOV.UK Frontend

This document explains how we upgraded GovWifi Product Pages to use `v3.0` of GOV.UK Frontend. This
newer version of the library replaces GOV.UK Elements, Frontend Toolkit and parts of GOV.UK
Template.

From a very high level, the overall upgrade process, therefore, involved the following:

* upgrading the NPM package `govuk-frontend` `2.x` to `3.0`
* removing the dependency on NPM packages `govuk-elements-sass` and `govuk_frontend_toolkit`
* fixing any issues arising as a result of these

### How we upgraded

#### Research

We started off by reading through the [changelog] for [GOV.UK Frontend][frontend], which explains most of the
major changes.

We also looked at the [upgrade guide][upgrade-guide] on [GOV.UK Design System][design-system], which
provides more context for the changes required.

#### Update NPM dependencies

We updated the version of `govuk-frontend` to `3.0.0`, and removed `govuk-elements-sass` and
`govuk_frontend_tookit` from `package.json`, followed by building the app in order to assess the
impact of these changes. As expected, the build failed as the changes introduced were quite
significant.

#### Migrate code

At this point, we ported the existing code to use the upgraded library, and removed any usage of the
removed libraries. In order to achieve this, the changelog and the upgrade guide were referenced,
until we were able to build the app without errors. This was very much an iterative process and
involved a lot of repetitive changes, such as changing class names for certain HTML elements.

#### Fix styling

Since we had to remove all references to the removed libraries, most of the pages of the app had
their styling broken, and this is what we fixed next.

The existing codebase included a lot of custom styling, for things such as the site header, which
are now provided by `govuk-frontend` as components. Therefore, we ported the views and layout
markups to make use of the components provided by the Design System, and got rid of any unnecessary
and redundant CSS.

#### Fine tuning

Once we had ported the code over to use components provided by the Design System, we began fine
tuning the styling in order to bring back some of the uniqueness of the app. This was kept to a
minimum so as to keep the look and feel as consistent with the Design System as possible, which
should also make future upgrades easier.

[changelog]: https://github.com/alphagov/govuk-frontend/releases/tag/v3.0.0
[frontend]: https://github.com/alphagov/govuk-frontend
[design-system]: https://design-system.service.gov.uk
[upgrade-guide]: https://design-system.service.gov.uk/get-started/updating-your-code
