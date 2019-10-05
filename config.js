exports.creds = {
  // Required
   identityMetadata: 'https://login.microsoftonline.com/f0cda840-82d0-46f0-a2fe-726201523c33/v2.0/.well-known/openid-configuration',
   // or equivalently: 'https://login.microsoftonline.com/<tenant_guid>/v2.0/.well-known/openid-configuration'
   //
   // or you can use the common endpoint
   // 'https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration'
   // To use the common endpoint, you have to either turn `validateIssuer` off, or provide the `issuer` value.

   // Required, the client ID of your app in AAD
   clientID: '1f62ee5a-662f-4372-9418-5fe7c6391f09',

   // Required, must be 'code', 'code id_token', 'id_token code' or 'id_token'
   // If you want to get access_token, you must use 'code', 'code id_token' or 'id_token code'
   responseType: 'code id_token',

   // Required
   responseMode: 'form_post',

   // Required, the reply URL registered in AAD for your app
   //redirectUrl: 'https://links-app.azurewebsites.net/auth/openid/return',
   redirectUrl: 'http://localhost:3000/auth/openid/return',

   // Required if we use http for redirectUrl
   allowHttpForRedirectUrl: true,

   // Required if `responseType` is 'code', 'id_token code' or 'code id_token'.
   // If app key contains '\', replace it with '\\'.
   clientSecret: 'o4yz1Wh5@]zvE1_yUqSo_2n6NfK[1mY?',

   // Required to set to false if you don't want to validate issuer
   validateIssuer: false,

   // Required if you want to provide the issuer(s) you want to validate instead of using the issuer from metadata
   // issuer could be a string or an array of strings of the following form: 'https://sts.windows.net/<tenant_guid>/v2.0'
   issuer: null,

   // Required to set to true if the `verify` function has 'req' as the first parameter
   passReqToCallback: false,

   // The additional scopes we want besides 'openid'.
   // 'profile' scope is required, the rest scopes are optional.
   // (1) if you want to receive refresh_token, use 'offline_access' scope
   // (2) if you want to get access_token for graph api, use the graph api url like 'https://graph.microsoft.com/mail.read'
   scope: ['profile', 'offline_access', 'https://graph.microsoft.com/mail.read'],

   // Optional, 'error', 'warn' or 'info'
   loggingLevel: 'error',

   // Optional. The lifetime of nonce in session or cookie, the default value is 3600 (seconds).
   nonceLifetime: null,

   // Optional. The max amount of nonce saved in session or cookie, the default value is 10.
   nonceMaxAmount: 5,

   // Optional. The clock skew allowed in token validation, the default value is 300 seconds.
   clockSkew: null
};

// The url you need to go to destroy the session with AAD
exports.destroySessionUrl = 'https://login.microsoftonline.com/common/oauth2/logout?post_logout_redirect_uri=http://localhost:3000';

exports.port = 3000
