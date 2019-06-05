# Certificate Authentication (Alpha)

## What is Certificate Authentication
Device-Wifi requires a user to have either a government email address, be sponsored by someone with a government email address, or have a mobile phone number. Device-Wifi only requires that a certificate needs to be installed on a device to gain access, this removes the need to always enter an email and password to gain access to government Wifi.

## How it works
1. Register your organisation with the GovWifi Admin portal and setup the “GovWifi” SSID on your local network.
2. Setup a “Certificate Authority” using a Public Key Infrastructure (PKI) software tool. This allows the organisation to sign certificates.
3. Using your PKI, sign client certificates.
4. Provide us with your root CA certificate used to sign these client certificates.
5. Devices can now connect to the internet via GovWifi wherever GovWifi is offered.

![process]

## Where is the code
You can find the code for Certificate Authentication within the [govwifi-frontend](https://github.com/alphagov/govwifi-frontend) repo

## What an organisation has to do to connect
- Organisations use their own Public Key Infrastructure (PKI).
- Organisations will provide their root CA certificate to GovWifi. Any valid client certificate signed with this root CA certificate will           successfully authenticate. This requires the organisation to have its own PKI system.
- Client certificates can be installed on target devices.
- Organisations need to issue a 802.1x profiles to their devices.
  - In a windows environment its done using group policy settings.
  - In a macOS environment its via the management software which could be JAMF or something like Munki.
- The profile should ONLY trust the GovWifi RADIUS certificate. This protects against Man in the middle attacks.


[process]: images/cert_auth.png "Certificate Authentication Process"
