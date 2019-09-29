const express = require('express');
const mysql = require('mysql');
const cors = require('cors')
const path = require('path');
const uuid = require('uuid/v4');
const session = require('express-session');
const MySQLStore = require('express-mysql-session')(session);
const passport = require('passport');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const LocalStrategy = require('passport-local').Strategy;
const LdapStrategy = require('passport-ldapauth');

const app = express();
app.use(cors());
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())
app.use(cookieParser());

const data = new Date();

const db = mysql.createConnection({
  host    : 'localhost',
  user    : 'janick67',
  password: 'janick67a',
  database: 'links'
})

db.connect((err) => {
  if(err) throw err;
  console.log(aktualnaData()+'MySql Connected...');
});



const sessionStore = new MySQLStore({
    expiration: 10800000,
    createDatabaseTable: true,
    schema: {
        tableName: 'sessions',
        columnNames: {
            session_id: 'session_id',
            expires: 'expires',
            data: 'data'
}}}, db);

var WindowsStrategy = require('passport-windowsauth');

passport.use(new WindowsStrategy({
  ldap: {
    url:             'ldap://ldap.forumsys.com:389/dc=example,dc=com',
    base:            'dc=example,dc=com',
    bindDN:          'read-only-admin',
    bindCredentials: 'password'
  }
}, function(profile, done){
  console.log(profile);
  User.findOrCreate({ waId: profile.id }, function (err, user) {
    console.log(user);
    done(err, user);
  });
}));

var OptLDAP = {
  server: {
    url: "ldap://ldap.forumsys.com:389",
    adminDn: "cn=read-only-admin,dc=example,dc=com",
    adminPassword: "password",
    searchBase: "dc=example,dc=com",
    searchFilter: "(uid={{username}})"
}
};

passport.use(new LdapStrategy(OptLDAP));
//
// configure passport.js to use the local strategy
passport.use(new LocalStrategy((username, password, done) => {
    // console.log('Inside local strategy callback')
    db.query(`select * from users where username = "${username}"`,(err, result) => {
        if (err){return console.log(err)};
        const user = result[0];
        // console.log('Użytkownik z Local: ',email, typeof email,password, typeof password);
        if (typeof user === 'undefined') {return done(true, false);}
        // console.log('Użytkownik z bazy: ',user.email ,typeof user.email, user.password,typeof user.password);
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
passport.serializeUser((user, done) => {
  //console.log('Inside serializeUser callback. User id is save to the session file store here')
  done(null, user.uid);
});

passport.deserializeUser((uid, done) => {
//  console.log('Inside deserializeUser callback')
  //console.log(`The user id passport saved in the session file store is: ${id}`)
  done(null,{uid})
  // db.query(`select * from users where id = "${id}"`, function (err, rows){
  //     //console.log('rows: ', rows);
  //       done(err, rows[0]);
  // });
});

// add & configure middleware
app.use(session({
  genid: (req) => {
    // console.log('Inside the session middleware')
  //  console.log(req.sessionID)
    return uuid() // use UUIDs for session IDs
  },
  store: sessionStore,
  secret: 'keyboard cat',
  resave: true,
  saveUninitialized: true
}))

app.use(passport.initialize());
app.use(passport.session());

app.use(function(req, res, next) {
        console.log("\n\n\nścieżka: ", req.path);
        if (typeof req.user !== 'undefined') console.log("użytkownik: ", req.user.username);
        else console.log("Brak użytkownika");
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
    if(typeof req.user === 'undefined' && req.path.indexOf('api/login') <= 0){
        return res.status(404).send("Najpierw się zaloguj");
    }
    next();
  });

app.post('/api/login', (req, res, next) => {
  // console.log('Inside the new POST /login callback')
  console.log(req.body)
  passport.authenticate('ldapauth', (err, user, info) => {
    console.log("(err, user, info)",err, user, info);
    if (err || !user) return res.send({error:"Nie udało się uwierzytelnic",user:null});
    console.log('Inside passport.authenticate() callback');
    console.log(`req.session.passport: ${JSON.stringify(req.session.passport)}`)
    console.log(`req.user: ${JSON.stringify(req.user)}`)
    req.login(user, (err) => {
      console.log('Inside req.login() callback')
      console.log(`req.session.passport: ${JSON.stringify(req.session.passport)}`)
      console.log(`req.user: ${JSON.stringify(req.user)}`);
      return res.send({error:null,user:user.uid});
    })
  })(req, res, next)
});

app.get('/api/logout',(req, res) => {
  req.logout();
  res.send("ok");
  res.redirect('/');
});

app.get('/api/links/',(req,res) => {
    let sql = `SELECT l.* FROM users u
              join roles r on u.roleid = r.id
              join roleslinks rl on rl.roleid = r.id
              join links l on l.id = rl.linkid
              WHERE u.uid = "${req.user.uid}"`;
    const query = db.query(sql, (err, result) => {
    if (err){console.error(err);  return res.send(err)};
    res.send(result);
    });
})

app.use(function(req, res, next) {
  return res.status(404).send('Route '+req.url+' Not found.');
});

app.listen(3001, () => console.log(aktualnaData()+'Listen on port 3001....'))




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
