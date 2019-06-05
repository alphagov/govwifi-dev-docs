# GovWifi Zendesk Summary

## Macros:

### For End Users:
GovWifi - End User Password Request
GovWifi - End User Connection Issue
GovWifi - End user trying to connect via admin portal
GovWifi - Non-government end user password request
GovWifi - End user email not received

### For Admin Users:
GovWifi - Close and do not reply
GovWifi - Organisation name not on list
GovWifi - Poster request
GovWifi - Log Request
GovWifi - Is GovWifi down?


#### Common Issues End User Issues

#### End User:

1. Can I have a password?
  - Use macro GovWifi - End User Password Request.
2. Can you reset my password?
  - Passwords are not reset, but you can re-request the same username and password in the same way as signing up.
  - Use macro GovWifi - End User Password Request.
3. My username and password aren’t being accepted
  - This is usually because the user is spelling the username / password wrong, or the username / password is ambiguous.
  - It can also be because of a device configuration or network configuration issue
  - Use macro: GovWifi - End User Connection Issue
  - This is sometimes due to a read-replica lag where the read replica database is a few minutes behind the production database. This means a new user will not appear immediately in the database leading to authentication failures until the read replica catches up.
4. My phone won’t connect
  - Usually a device related issue
  - Use macro: GovWifi - End User Connection Issue
5. I didn’t receive the email
  - This usually happens when the email with username / password goes to the users spam folder.
  - This can be checked by logging into Gov.UK Notify and searching for the email address
  - Use macro: GovWifi - End user email not received
6. My connection constantly drops out along with my colleagues at the same location
  - Usually a local network issue and can be caused by network clash.
  - You will usually see similar complaints from users at the same location
  - Reach out to the network engineers at this location / organisation to explain the situation and offer assistance
  - It is worth reaching out to the network admins of the building and attempting to problem solve the root cause.

#### End User:
7. We would like to try GovWifi, can you answer…..
  - Usually assigned to Steve Wood as Service Owner.
8. I’m wanting to offer GovWifi but our organisation name is not on the list.
  - The organisation name needs to be whitelisted via the super admin platform, along with the email domain.
9. The following user is having issues connecting
  - When this comes from a network administrator it is usually a tricky issue to debug and may take some time.
  - Always check that GovWifi is up by checking www.admin.wifi.service.gov.uk/status
  - Often these requests come from first line IT support who have not spent adequate time problem solving the issue (usually caused by an incorrect username or password, or misconfigured device).
10. Please give me the details of the following user
  - Always ensure that this request is coming from a known network administrator in that team
  - Usually occurs when a user breaches the local network T&Cs.
  - Access the database to find the users contact details (email or phone) given their username or mac address, pass this to the organisation.
11. Please block the following user…
  - We do not block users from GovWifi. In these cases it is usually an end user who has breached their local network T&Cs, rather than GovWifi’s. It's not our responsibility to block users.
  - Network engineers can block users from their local network while they retain access to GovWifi at different locations.



