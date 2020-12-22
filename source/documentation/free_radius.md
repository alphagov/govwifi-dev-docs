# FreeRADIUS

## AAA

GovWifi currently has a set of 6 RADIUS servers. These servers control network access with [AAA authentication][aaa link].
![radius exchange]

### Authentication

- Runs on port 1812.
- Requests user details stored in the database via the [Authentication API][authentication api link].

### Authorisation

- We do not have different levels of access so this is a NOOP.

### Accounting

- Runs on Port 1813.

- While we don't block accounting requests, we don't do anything with them. If an organisation requires accounting, they can enable it on their local infrastructure.

## Unlang

FreeRADIUS is configured using a language called [Unlang][unlang docs link].

We favor keeping all complex functionality in the backend APIs, instead of in Unlang.

This way it is easier to test and change in the future.

![free radius]

## FreeRADIUS Server

This is the software installed on our RADIUS servers.

It is opensource and can be found on [Github][free radius server link].

![free radius server]

## The RADIUS Healthcheck

The Route53 healthcheck connects to port 3000 on a specific radius machine. For example:
```http://12.345.678.91:3000/
```
A ruby process listens on port 3000. When it receives a request for “/“ it automatically runs an eapol_test command. The code for this can be seen here: https://github.com/alphagov/govwifi-frontend/blob/master/healthcheck/app.rb#L28 . The eapol_test command will connect to the Authentication API, and if it is successful it will return a 200 response.

The configuration file for the healthcheck eapol_test can be found here:
https://github.com/alphagov/govwifi-frontend/blob/master/healthcheck/peap-mschapv2.conf.erb

If you need to manually test the healthcheck in a radius docker container you can do:
```eapol_test -c /usr/src/healthcheck/peap-mschapv2.conf -s $(echo $HEALTH_CHECK_RADIUS_KEY)
```

The secret can also be found by logging in as a GovWifi administrator( for staging you would login [here](https://admin.staging.wifi.service.gov.uk/) ), switching to the GDS CTS organisation, then selecting “Locations” and scrolling to “Health check user”

It should also be noted that the last login of the health check user is no longer recorded in the User database.

The failure of the health check does not actually trigger a new Radius docker container to be spawned. It only sends a notification email to govwifi-devops@digital.cabinet-office.gov.uk .

You can learn more about the healthcheck [here](https://github.com/alphagov/govwifi-frontend#healthcheck).

## Debugging

### Verbose Logging

Starting the freeRADIUS server with the `-X` flag will enable verbose logging.

This is managed through the [GovWifi Terraform][govwifi terraform link].  Due to the volume of transactions on production, enabling this may have an impact on performance.

A better way to use this would be to enable it on staging and to have the client who is having trouble connect to that IP.

Production and staging logs can be found in CloudWatch under `wifi-frontend-docker-log-group` and `staging-frontend-docker-log-group` respectively.

It will contain all the details of the authentication request which can be used to diagnose issues.

![free radius logs]

### Mailing List

You can get help from the FreeRADIUS community by asking questions on their [user mailing list][mailing list link].

You will need to sign up before you can ask questions or gain access to the archives.

### eapol_test

In order to simulate UDP requests locally, there is a tool called [eapol_test][eapol test link].

This is currently used in full-stack automated testing and health checking.

![eapol test]

### Common error messages
```
Error: Ignoring request to auth address * port 1812 bound to server default from unknown client
```
This means that the client isn't whitelisted by the RADIUS server.

```
invalid Request Authenticator! (Shared secret is incorrect.)
```
The server knows the IP but it failed to authenticate with its pre-shared key.


[aaa link]: https://en.wikipedia.org/wiki/AAA_(computer_security)
[authentication api link]: https://github.com/alphagov/govwifi-authentication-api
[directory structure]: /images/directory_structure.png "Directory Structure"
[eapol test link]: http://deployingradius.com/scripts/eapol_test/
[eapol test]: /images/eapol_test.png "EAPOL test"
[free radius logs]: /images/free_radius_logs.png "Radius Verbose logging"
[free radius]: /images/free_radius.png "Free RADIUS"
[free radius server]: /images/free_radius_server.png "Free RADIUS Server"
[free radius server link]: https://github.com/FreeRADIUS/freeradius-server
[mailing list link]: http://lists.freeradius.org/mailman/listinfo/freeradius-users
[radius exchange]: /images/radius_exchange.png "Exchange with Supplicant"
[unlang docs link]: https://freeradius.org/radiusd/man/unlang.html
[govwifi terraform link]: https://github.com/alphagov/govwifi-terraform
