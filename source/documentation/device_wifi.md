# Certificate Authentication (Alpha)

## What is Certificate Authentication
GovWifi requires a user to have either a government email address, be sponsored by someone with a government email address, or have a mobile phone number. Many users re-used their own personal username and password multiple times for managed devices as a workaround for not having a certificate based system to use.
However with certificate based authentication it means that a device can connect rather than a person, this removes the need to remember a username and password everytime you want to connect to the internet. This then also solves the problem of IT manager's needing to connect dozens of managed devices.

## How it works
1. Register your organisation with the GovWifi Admin portal and setup the “GovWifi” SSID on your local network.
2. Setup a “Certificate Authority” using a Public Key Infrastructure (PKI) software tool. This allows the organisation to sign certificates.
3. Using your PKI, sign client certificates.
4. Provide us with your root CA certificate used to sign these client certificates.
5. Devices can now connect to the internet via GovWifi wherever GovWifi is offered. However that when connecting to GovWifi that EAP-TLS is selected.

![process]

## Where is the code
- You can find the code for Certificate Authentication within the [govwifi-frontend](https://github.com/alphagov/govwifi-frontend) repo
- You can find where the EAP-TLS is handled in FreeRADIUS [here](https://github.com/alphagov/govwifi-frontend/blob/master/radius/mods-enabled/eap#L7)
- You can find the folder where the root CA certificates are held [here](https://github.com/alphagov/govwifi-frontend/blob/4b65fd464c7362ad8bb5d0773ec61177faf90eb2/Dockerfile#L50)

## Common Issues
- Organisations may send us CA certificates that either don't have the full chain of trust or aren't actually the CA certs that signed the client certs

[process]: images/cert-auth.png
