# On site MYSQL backups

All the GovWifi databases are backed up at 3am daily by the internal GDS build server.
In order to connect to mysql, it has to go through the bastion server.

The script that does the backups is located in: 

`/root/Scripts/govwifi-backup.sh`

You can ssh into this server:

`ssh -i ~/.ssh/bob -vvvv bob@ah-govwf-d-01.dmz.gds`

You need to be on a VPN to gain access to this server.
Please speak to the security team to get you set up on this.

To get notifications about these backups, please subscribe to the `GovWifi-DevOps` Google Group.

## Caveat 

Rotating a bastion server requires that you remove it from the `known_hosts` file on this build server.

`/root/.ssh/known_hosts`
