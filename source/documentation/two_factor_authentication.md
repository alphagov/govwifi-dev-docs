# Two factor authentication

Two factor authentication is currently only enforced for Super Admin users in the Admin application.

We use the [`two_factor_authentication`](https://github.com/Houdini/two_factor_authentication) gem to integrate the Time-based One Time Password (TOTP) functionality
with the existing Devise authentication modules.


## 2FA Set up

The Admin application contains a custom setup step which differs from the presumptions of the `two_factor_authentication` gem.

Where 2FA is enforced for a user they will be presented with a setup step as they log in to the Admin app.

A QR code will be generated for them and this should be scanned with an appropriate authenticator phone application.

![Setting up 2FA](images/setup-2fa.png)

The `Users::TwoFactorAuthenticationSetupController` handles the generation of a QR code URI and saving the initial setup against the User model assuming they provide the correct TOTP.

For subsequent logins, when they have successfully entered the correct code the 2FA cookie is set to expire in 24 hours, meaning they will need to enter the relevant TOTP from the authenticator app again. This does not change the user session timeout set by Devise configuration, so authentication sessions will still expire after 1 hour.


## Configuration options for 2FA

The `two_factor_authentication` gem comes with a number of configuration options which can be found in [`config/initializers/devise.rb`](https://github.com/alphagov/govwifi-admin/blob/master/config/initializers/devise.rb).

```
config.max_login_attempts = 3  # Maximum second factor attempts count.
config.allowed_otp_drift_seconds = 30  # Allowed TOTP time drift between client and server.
config.otp_length = 6  # TOTP code length
config.remember_otp_session_for_seconds = 86400 # Time before browser has to perform 2fA again. Currently 24 hours.
config.otp_secret_encryption_key = ENV['OTP_SECRET_ENCRYPTION_KEY']
config.second_factor_resource_id = 'id' # Field or method name used to set value for 2fA remember cookie
config.delete_cookie_on_logout = false # Delete cookie when user signs out, to force 2fA again on login
```

[`OTP_SECRET_ENCRYPTION_KEY` is configured via Terraform](https://github.com/alphagov/govwifi-terraform/commit/11a21b03915a6977e6bc10217513005f05ea7576) and different between staging and production environments, which means that different TOTP codes will be generated between environments.


## Configuring how 2FA is enforced

The `two_factor_authentication` gem will enforce 2FA for all users by default. We control how 2FA is applied via the [`need_two_factor_authentication?` method on the User model](https://github.com/alphagov/govwifi-admin/blob/master/app/models/user.rb#L54).  
With this method we can include or exclude users from other organisations, it's also possible to configure whether 2FA is necessary in specific environments.


## Resetting 2FA

Currently there isn't a convenient method for resetting a user's 2FA. This means that when a user changes authentication device they may need developer assistance to set up 2FA again.

To reset a user's 2FA credentials in a Rails console:

```
current_user.second_factor_attempts_count=nil
current_user.encrypted_otp_secret_key=nil
current_user.encrypted_otp_secret_key_iv=nil
current_user.encrypted_otp_secret_key_salt=nil
current_user.totp_timestamp=nil
current_user.otp_secret_key=nil
current_user.save!
```

This may also be done via a Rails migration or directly against the relevant database.
