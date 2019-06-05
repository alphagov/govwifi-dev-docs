# Certificate Authentication (Alpha)

## What is Certificate Authentication
GovWifi requires a user to have either a government email address, be sponsored by someone with a government email address, or have a mobile phone number. Many users re-used their own personal username and password multiple times for managed devices as a workaround for not having a certificate based system to use.
However with certificate based authentication it means that a device can connect rather than a person, this removes the need to remember a username and password everytime you want to connect to the internet. This then also solves the problem of IT manager's needing to connect dozens of managed devices.

## How it works
1. Register your organisation with the GovWifi Admin portal and setup the “GovWifi” SSID on your local network.
2. Setup a “Certificate Authority” using a Public Key Infrastructure (PKI) software tool. This allows the organisation to sign certificates.
3. Using your PKI, sign client certificates.
4. Provide us with your root CA certificate used to sign these client certificates.
5. Devices can now connect to the internet via GovWifi wherever GovWifi is offered. However when connecting to GovWifi that EAP-TLS is selected.

![process]

## Where is the code
- You can find the code for Certificate Authentication within the [govwifi-frontend](https://github.com/alphagov/govwifi-frontend) repo
- You can find where the EAP-TLS is handled in FreeRADIUS [here](https://github.com/alphagov/govwifi-frontend/blob/master/radius/mods-enabled/eap#L7)
- You can find the folder where the root CA certificates are held [here](https://github.com/alphagov/govwifi-frontend/blob/4b65fd464c7362ad8bb5d0773ec61177faf90eb2/Dockerfile#L50)

## Common Issues
- Organisations may send us CA certificates that either don't have the full chain of trust or aren't actually the CA certs that signed the client certs
- For organisations with limited IT resources GovWifi Devices is more difficult to set up and manage.
- For organisations using a Windows operating system, GovWifi Devices is more difficult to set up.
- Organisations have a lack of knowledge about how certificate authentication works, specifically around openSSL
- The time taken to receive certificates from organisations is much longer than anticipated.
- Organisations are having to seek security permissions and sign-off from decision makers, before they can send their certificate.
- The process of receiving certificates by email and uploading them manually is time consuming for service developers.
- Organisations may be unaware that certificates expire, which could generate a support load from end-users that is unmanageable for service  developers.

For more information about the user research that has gone into Certificate Authentication thus far click [here](https://docs.google.com/presentation/d/1k0pr32ZmJ7NHVCEf4_sWLrt2pL_e5vtgcezPBdPLZ5A/edit#slide=id.g4c75c45c21_0_17)

[process]: images/cert-auth.png
