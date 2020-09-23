# Device Wifi: Certificate Authentication (Alpha)

## What is Certificate Authentication
GovWifi requires a user to have either a government email address, be sponsored by someone with a government email address, or have a mobile phone number. Many users re-used their own personal username and password multiple times for managed devices as a workaround for not having a certificate based system to use.

However with certificate based authentication it means that a device can connect rather than a person, this removes the need to remember a username and password everytime you want to connect to the internet. This then also solves the problem of IT manager's needing to connect dozens of managed devices.

Note that this is an alpha feature. A handful of organisations were selected to participate in the alpha pilot, and it is not currently open to new organisations.

## How it works
1. Register your organisation with the GovWifi Admin portal and setup the “GovWifi” SSID on your local network.
2. Setup a “Certificate Authority” using a Public Key Infrastructure (PKI) software tool. This allows the organisation to sign certificates.
3. Using your PKI, sign client certificates (i.e. certificates to be used by any devices being connected to GovWifi).
4. Provide us with your root/intermediate CA certificate used to sign these client certificates.
5. Devices can now connect to the internet via GovWifi wherever GovWifi is offered. However when connecting to GovWifi that EAP-TLS is selected.

![process]

## Where is the code
- You can find the code for Certificate Authentication within the [govwifi-frontend](https://github.com/alphagov/govwifi-frontend) repo
- You can find where the EAP-TLS is handled in FreeRADIUS [here](https://github.com/alphagov/govwifi-frontend/blob/master/radius/mods-enabled/eap#L7)
- You can find the folder where the root CA certificates are held [here](https://github.com/alphagov/govwifi-frontend/blob/4b65fd464c7362ad8bb5d0773ec61177faf90eb2/Dockerfile#L49)

## Common tasks

### Receive changes to root/intermediate CA certificates from organisations

As mentioned above, organisations send us their root/intermediate CA certificates. These are kept in `govwifi-build`, in the encrypted file `passwords/certs/production/ca.pem.gpg`. Therefore, in case an organisation wants to send us new certificates or delete existing ones, this file would need to be edited to add or remove them. To edit this, do this:

`PASSWORD_STORE_DIR=<password_store_dir> pass edit passwords/certs/production/ca.pem`

Once a change has been made to this file and it has been merged into the main branch, the Concourse pipeline `sync-frontend-certs` gets triggered, which syncs the certificates to an S3 bucket which is read by the FreeRADIUS servers during initialisation. Note that this is only synced to staging automatically, and syncing to production must be triggered manually from Concourse, in order for any changes to take effect for production users.

## Common issues
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
