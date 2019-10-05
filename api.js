const express = require('express');
const cors = require('cors')
const path = require('path');
const uuid = require('uuid/v4');
const session = require('express-session');
const sqlite3 = require('sqlite3').verbose();
const SQLiteStore = require('connect-sqlite3')(session);
const passport = require('passport');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
var OIDCStrategy = require('passport-azure-ad').OIDCStrategy;
var config = require('./config');

const app = express();
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())
app.use(cookieParser());

const  users = []; //po zalogowaniu jest tam wrzucany użytkownik a nastepnie jest pobierany prze każdej deserializacji

const findByOid = function(oid, fn) {//przy deserializacji żeby pobrać użytkownika z tabeli
  console.log(users.length);
  if (typeof users[0] !== 'undefined' && typeof users[0]._json !== 'undefined') {
    users.forEach(el=>{
      console.log(el._json.groups);
    })
  }
  for (let i = 0, len = users.length; i < len; i++) {
    var user = users[i];
    if (user.oid === oid) {
      return fn(null, user);
    }
  }
  return fn(null, null);
};

const azureOptions ={//cała konfiguracja pobierana z pliku config
  identityMetadata: config.creds.identityMetadata,
   clientID: config.creds.clientID,
   responseType: config.creds.responseType,
   responseMode: config.creds.responseMode,
   redirectUrl: config.creds.redirectUrl,
   allowHttpForRedirectUrl: config.creds.allowHttpForRedirectUrl,
   clientSecret: config.creds.clientSecret,
   validateIssuer: config.creds.validateIssuer,
   isB2C: config.creds.isB2C,
   issuer: config.creds.issuer,
   passReqToCallback: config.creds.passReqToCallback,
   scope: config.creds.scope,
   loggingLevel: config.creds.loggingLevel,
   nonceLifetime: config.creds.nonceLifetime,
   nonceMaxAmount: config.creds.nonceMaxAmount,
   clockSkew: config.creds.clockSkew,
 }

passport.use(new OIDCStrategy(azureOptions, //decyzja o tym z jakiego sposobu uwierzytelniania korzystamy
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

//połaczenie do bazy z pliku
let db = new sqlite3.Database('./db/data.sqlite',sqlite3.OPEN_READWRITE, (err) => {
  if (err) {
    console.error(err.message);
  }
});


// tell passport how to serialize the user
passport.serializeUser(function(user, done) {
  done(null, user.oid);
});

passport.deserializeUser(function(oid, done) {
  findByOid(oid, function (err, user) {
    done(err, user);
  });
});

// konfiguracja sessji
app.use(session({
        store: new SQLiteStore({
          dir:'./db/',
          table:'sessions',
          db:'data.sqlite'
        }),
        secret: 'my secret124',
        resave: false,
        saveUninitialized: true,
        cookie: { maxAge: 7 * 24 * 60 * 60 * 1000 } // 1 week
      }))

app.use(passport.initialize());
app.use(passport.session());

app.use(function(req, res, next) { //pilnowanie ściezki, nie zalogowany użytkownik ma dostep tylko do logowania czyli /auth/openid/return
        if (typeof req.user !== 'undefined') console.log("użytkownik: ", req.user.username);
        else console.log("Brak użytkownika");
        if (typeof req.user === 'undefined' && req.path.indexOf('/auth/openid/return') == -1)
          {
             console.log("Przekierowywuje Cie do logowania");
             return  res.redirect('../auth/openid/return');
          }
    next();
  });

app.get('/api/links/',(req,res) => {// api do pobierania linków
  let groups = ''
  req.user._json.groups.forEach(el=>{
    groups+=`"${el}",`
  })
  groups = `(${groups.substr(0,groups.length-1)})`
    let sql = `SELECT DISTINCT l.* FROM groups g
           join grouplinks gl on gl.groupId = g.id
           join links l on l.id = gl.linkid
           WHERE g.oid in ${groups}`;
    const query = db.all(sql,[], (err, result) => {
    if (err){console.error(err);  return res.send({err,result:null})};
    res.send({error:null,result});
    });
})


app.get('/auth/openid/return', //tutaj zaczyna się logowanie i azure wysyła odpowiedz po zalogowaniu
  function(req, res, next) {
    passport.authenticate('azuread-openidconnect',
      {
        response: res,                      // required
        failureRedirect: '/'
      }
    )(req, res, next);
  },
  function(req, res) {
    res.redirect('/');
  });

app.post('/auth/openid/return', //tutaj zaczyna się logowanie i azure wysyła odpowiedz po zalogowaniu
  function(req, res, next) {
    passport.authenticate('azuread-openidconnect',
      {
        response: res,                      // required
        failureRedirect: '/'
      }
    )(req, res, next);
  },
  function(req, res) {
    res.redirect('/');
  });

// 'logout' route, logout from passport, and destroy the session with AAD.
app.get('/logout', function(req, res){
  req.session.destroy(function(err) {
    req.logOut();
    res.redirect('https://login.microsoftonline.com/common/oauth2/logout?post_logout_redirect_uri=https://links-app.azurewebsites.net');
  });
});

app.use(express.static('./front/')); //udostępnianie plików statycznych z frontem

app.use(function(req, res, next) {
  return res.status(404).send('Route '+req.url+' Not found.');
});



app.listen(config.port, () => console.log('Listen on port '+config.port+'....'))
