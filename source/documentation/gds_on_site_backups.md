# On site MYSQL backups

All the GovWifi databases are backed up at 3am daily by the internal GDS build server.
In order to connect to mysql, it has to go through the bastion server.

The script that does the backups is located in: 

`/root/Scripts/govwifi-backup.sh`

**Rotating our bastion server will cause these backups to fail with the following error** 

*WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!*

You can fix this by removing the entry from the `/root/.ssh/known_hosts` file.

## SSH access requirements
### VPN

You need to be on a GovWifi specific VPN to gain access to this server.
To get on this VPN, you will need to open a support request on the GDS helpdesk.

### User Account

Please speak to the RE-Gov.Wifi team to get you set up on this.

You will need someone with SSH access to set up your user account on the server:

`useradd -m -G sudo USERNAME`

You should now be able to ssh into this server:

`ssh -i ~/.ssh/bob -vvvv bob@ah-govwf-d-01.dmz.gds`

## Notifications

To get notifications about these backups, please subscribe to the `GovWifi-DevOps` Google Group.
