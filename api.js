const express = require('express');
const mysql = require('mysql');
const cors = require('cors')
const path = require('path');
const uuid = require('uuid/v4');
const session = require('express-session');
//const MySQLStore = require('express-mysql-session')(session);
const sqlite3 = require('sqlite3').verbose();
const SQLiteStore = require('connect-sqlite3')(session);
const passport = require('passport');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const LocalStrategy = require('passport-local').Strategy;
var OIDCStrategy = require('passport-azure-ad').OIDCStrategy;

const app = express();
app.use(cors());
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())
app.use(cookieParser());

//
// var options = {
//   identityMetadata: 'https://login.microsoftonline.com/f0cda840-82d0-46f0-a2fe-726201523c33/v2.0/.well-known/openid-configuration',
//   clientID: '1f62ee5a-662f-4372-9418-5fe7c6391f09',
//
//   // Required.
//   // If you are using the common endpoint, you should either set `validateIssuer` to false, or provide a value for `issuer`.
//   validateIssuer: true,
//
//   // Required.
//   // Set to true if you use `function(req, token, done)` as the verify callback.
//   // Set to false if you use `function(req, token)` as the verify callback.
//   passReqToCallback: false,
//
//   // Required if you are using common endpoint and setting `validateIssuer` to true.
//   // For tenant-specific endpoint, this field is optional, we will use the issuer from the metadata by default.
//   issuer: null,
//
//   // Optional, default value is clientID
//   audience: null,
//
//   // Optional. Default value is false.
//   // Set to true if you accept access_token whose `aud` claim contains multiple values.
//   allowMultiAudiencesInToken: false,
//
//   // Optional. 'error', 'warn' or 'info'
//   loggingLevel:'info',
// };
//
// var bearerStrategy = new BearerStrategy(options,
//   function(token, done) {
//     console.console.log('elo jestem w');
//     log.info('verifying the user');
//     log.info(token, 'was the token retreived');
//     findById(token.oid, function(err, user) {
//       if (err) {
//         return done(err);
//       }
//       if (!user) {
//         // "Auto-registration"
//         log.info('User was added automatically as they were new. Their oid is: ', token.oid);
//         users.push(token);
//         owner = token.oid;
//         return done(null, token);
//       }
//       owner = token.oid;
//       return done(null, user, token);
//     });
//   }
// );
//
// passport.use(bearerStrategy);

var users = [];

var findByOid = function(oid, fn) {
  for (var i = 0, len = users.length; i < len; i++) {
    var user = users[i];
   console.log('we are using user: ', user);
    if (user.oid === oid) {
      return fn(null, user);
    }
  }
  return fn(null, null);
};

passport.use(new OIDCStrategy({
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
   redirectUrl: 'https://links-app.azurewebsites.net/auth/openid/return',

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
   loggingLevel: 'info',

   // Optional. The lifetime of nonce in session or cookie, the default value is 3600 (seconds).
   nonceLifetime: null,

   // Optional. The max amount of nonce saved in session or cookie, the default value is 10.
   nonceMaxAmount: 5,

   // Optional. The clock skew allowed in token validation, the default value is 300 seconds.
   clockSkew: null,
  },
  function(iss, sub, profile, accessToken, refreshToken, done) {
    if (!profile.oid) {
      return done(new Error("No oid found"), null);
    }
    // asynchronous verification, for effect...
    process.nextTick(function () {
      findByOid(profile.oid, function(err, user) {
        if (err) {
          return done(err);
        }
        if (!user) {
          // "Auto-registration"
          users.push(profile);
          return done(null, profile);
        }
        return done(null, user);
      });
    });
  }
));


const data = new Date();

let db = new sqlite3.Database('./db/data.sqlite',sqlite3.OPEN_READWRITE, (err) => {
  if (err) {
    console.error(err.message);
  }
  console.log('Connected to the database.');
});

// configure passport.js to use the local strategy
passport.use(new LocalStrategy(
  (username, password, done) => {
    console.log('Inside local strategy callback')
    db.all(`select * from users where username = "${username}"`,[],(err, result) => {
        if (err){return console.log(err)};
        const user = result[0];
        // console.log('Użytkownik z Local: ',username, password);
        if (typeof user === 'undefined') {return done(true, false);}
        // console.log('Użytkownik z bazy: ',user.username ,typeof user.username, user.password,typeof user.password);
        if(username == user.username && password == user.password) {
          // console.log('Local strategy returned true')
          return done(false, user)
        }else{
          // console.log('Local strategy returned false')
          return done(true, false);
        }
      });
    }
));

// tell passport how to serialize the user
passport.serializeUser(function(user, done) {
  done(null, user.oid);
});

passport.deserializeUser(function(oid, done) {
  findByOid(oid, function (err, user) {
    done(err, user);
  });
});
// passport.serializeUser((user, done) => {
//   //console.log('Inside serializeUser callback. User id is save to the session file store here')
//   done(null, user.id);
// });
//
// passport.deserializeUser((id, done) => {
// //  console.log('Inside deserializeUser callback')
//   //console.log(`The user id passport saved in the session file store is: ${id}`)
//
//   db.all(`select * from users where id = "${id}"`, [], function (err, rows){
//       //console.log('rows: ', rows);
//         done(err, rows[0]);
//   });
// });

// add & configure middleware
app.use(session({
        store: new SQLiteStore({dir:'./db/'}),
        secret: 'my secret124',
        cookie: { maxAge: 7 * 24 * 60 * 60 * 1000 } // 1 week
      }))

app.use(passport.initialize());
app.use(passport.session());

app.use(function(req, res, next) {
        console.log("\n\n\nścieżka: ", req.path);
        if (typeof req.user !== 'undefined') console.log("użytkownik: ", req.user.username);
        else console.log("Brak użytkownika");
        console.log(req.path.indexOf('/auth/openid/return'), req.path)
        if (typeof req.user === 'undefined' && req.path.indexOf('/auth/openid/return') == -1)
          {
             console.log("Przekierowywuje Cie do logowania");
             return  res.redirect('../auth/openid/return');
          }
        // console.log('-------------------------- session -----------------------------------------');
        // console.dir(req.sessionID);
        // console.log('------------------------------------------------------------------------------------');
        // console.log('-------------------------- cookies -----------------------------------------');
        // console.dir(req.cookies);
        // console.log('------------------------------------------------------------------------------------');
        // console.log('-------------------------- user -----------------------------------------');
        // console.dir(req.user);
        // console.log('------------------------------------------------------------------------------------');

    next();
  });

  app.use(function(req, res, next) {
    if(typeof req.user === 'undefined' && req.path.indexOf('api/') >= 0 && req.path.indexOf('api/login') <= 0 ){
        return res.status(404).send({error:"Najpierw się zaloguj",user:null});
    }
    next();
  });

app.post('/login', (req, res, next) => {
  console.log('Inside the new POST /login callback', req.body)
  passport.authenticate('azuread-openidconnect', (err, user, info) => {
    console.log("(err, user, info)",err, user, info);
    if (err || !user) return res.send({error:"Nie udało się uwierzytelnic",user:null});
    console.log('Inside passport.authenticate() callback');
    console.log(`req.session.passport: ${JSON.stringify(req.session.passport)}`)
    console.log(`req.user: ${JSON.stringify(req.user)}`)
    req.login(user, (err) => {
      console.log('Inside req.login() callback')
      console.log(`req.session.passport: ${JSON.stringify(req.session.passport)}`)
      console.log(`req.user: ${JSON.stringify(req.user)}`);
      return res.send({error:null,user:"Zalogowano pomyślnie"});
    })
  })(req, res, next)
});


app.get('/api/links/',(req,res) => {
    let sql = `SELECT l.* FROM users u
              join roles r on u.roleid = r.id
              join roleslinks rl on rl.roleid = r.id
              join links l on l.id = rl.linkid
              WHERE u.username = "${req.user.displayName}"`;
    const query = db.all(sql,[], (err, result) => {
    if (err){console.error(err);  return res.send(err)};
    // console.log('user: ',req.user,'sql: ',sql , 'result: ',result);
    res.send(result);
    });
})


// 'GET returnURL'
// `passport.authenticate` will try to authenticate the content returned in
// query (such as authorization code). If authentication fails, user will be
// redirected to '/' (home page); otherwise, it passes to the next middleware.
app.get('/auth/openid/return',
  function(req, res, next) {
    passport.authenticate('azuread-openidconnect',
      {
        response: res,                      // required
        failureRedirect: '/'
      }
    )(req, res, next);
  },
  function(req, res) {
    console.log('We received a return from AzureAD.');
    res.redirect('/');
  });

// 'POST returnURL'
// `passport.authenticate` will try to authenticate the content returned in
// body (such as authorization code). If authentication fails, user will be
// redirected to '/' (home page); otherwise, it passes to the next middleware.
app.post('/auth/openid/return',
  function(req, res, next) {
    passport.authenticate('azuread-openidconnect',
      {
        response: res,                      // required
        failureRedirect: '/'
      }
    )(req, res, next);
  },
  function(req, res) {
    console.log('We received a return from AzureAD.');
    res.redirect('/');
  });

// 'logout' route, logout from passport, and destroy the session with AAD.
app.get('/logout', function(req, res){
  req.session.destroy(function(err) {
    req.logOut();
    res.redirect('https://login.microsoftonline.com/common/oauth2/logout?post_logout_redirect_uri=https://links-app.azurewebsites.net');
  });
});



app.use(express.static('./front/'));

app.use(function(req, res, next) {
  return res.status(404).send('Route '+req.url+' Not found.');
});



app.listen(3000, () => console.log(aktualnaData()+'Listen on port 3001....'))




function aktualnaData(){
  const rok = leadingZero(data.getFullYear());
  const miesiac = leadingZero(data.getMonth()+1);
  const dzien = leadingZero(data.getDate());
  const godz = leadingZero(data.getHours());
  const min = leadingZero(data.getMinutes());
  const sec = leadingZero(data.getSeconds());
  return `[${dzien}.${miesiac}.${rok} ${godz}:${min}:${sec}] `
}

function leadingZero(i) {
  return (i < 10)? '0'+i : i;
}
