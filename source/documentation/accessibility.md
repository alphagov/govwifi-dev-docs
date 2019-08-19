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

#### Issues

Some issues arose from our porting effort:

* moving to `libsassc` proved more difficult than expected as there are some [known
  bugs](https://github.com/alphagov/govuk-frontend/issues/1350) with the newer gem and
  `govuk-frontend`, and some other gems in our dependencies haven't been ported either
  (govuk-lint, which is [being retired](https://github.com/alphagov/govuk-lint/issues/109) in
  the [process](https://github.com/alphagov/govuk-lint/issues/70));

* we missed a very important detail for the design of the new pages: any product in the
  government that is part of the GaaP effort (Notify, Pay, Registers, Wifi) should follow the
  example provided in
  [alphagov/product-page-example](https://github.com/alphagov/product-page-example/), with a
  compact header bar that fits in one row and makes better use of screen estate. It wasn't
  documented anywhere but pointed out to us by a designer in Notify.

* some of the patterns we use haven't been ratified by the design system yet: the side
  navigation is still custom (as is the design system's own sidebar) and roughly follows the
  example of the other GaaP products.
