var express  = require('express'),
    path     = require('path'),
    bodyParser = require('body-parser'),
    app = express(),
    request = require('request');
    expressValidator = require('express-validator');
    fs = require('fs');
    pg = require('pg');
    bd = require('./bd');


app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({ extended: true })); //support x-www-form-urlencoded
app.use(bodyParser.json());
app.use(expressValidator());


var server = app.listen(3000,function(){

   console.log("Listening to port %s",server.address().port);

});


app.get('/', function(req, res) {
  res.render('index.ejs');
});

//RESTful route
var router = express.Router();

var io = require('socket.io').listen(server);


/*------------------------------------------------------
*  This is router middleware,invoked everytime
*  we hit url /api and anything after /api
*  like /api/user , /api/user/7
*  we can use this for doing validation,authetication
*  for every route started with /api
--------------------------------------------------------*/
router.use(function(req, res, next) {
    console.log(req.method, req.url);
    next();
});

var curut = router.route('/pistas');


//show the CRUD interface | GET
curut.get(function(req,res,next){

  var fileContent = null;

  request('https://dzbnfrthri.execute-api.us-east-1.amazonaws.com/prod/getpistas', function (error, response) {
    if (!error && response.statusCode == 200) {
      fileContent = response.body
      fs.writeFile("json/pistas.json", fileContent, function(err) {
      if(err) {
        return console.log(err);
      }
      console.log(JSON.parse(fileContent));
      console.log("The file was saved!");
      });
    }
  })
  res.sendStatus(200); 

});

var curut2 = router.route('/pistas/iphone');

curut2.get(function(req,res,next){

  fs.readFile('json/pistas.json', 'utf8', function (err,data) {
    if (err) {
      console.log(err);
    }
    res.json(JSON.parse(data));
  });
  // res.sendStatus(200); 

});

//Outra Coisa




// var usernames = {};

// rooms which are currently available in chat
// var rooms = [1,2,3,4,5,6,7,8,9,10];

io.sockets.on('connection', function (socket) {

  // when the client emits 'adduser', this listens and executes
  socket.on('addUser', function(username, roomName){
    // store the username in the socket session for this client
    socket.username = username;
    // store the room name in the socket session for this client
    socket.room = roomName;
    // add the client's username to the global list
    // usernames[username] = username;
    // send client to room 1
    socket.join(roomName);
    // echo to client they've connected
    // socket.emit('updatechat', 'SERVER', 'you have connected to room1');
    // echo to room 1 that a person has connected to their room
    // socket.broadcast.to(roomName).emit('updatechat', 'SERVER', username + ' has connected to this room');

    bd.getMessages(pg, roomName, function(msgs) {

         socket.emit('loadChat', msgs); 
    });
  });

  io.on('disconnectUser', function(username, roomName){
    socket.leave(roomName);
  });

  socket.on('sendMessage', function(data) {

    console.log("Ta enviando a mensagem ----- "+ data[2]);
      socket.broadcast.to(data[1]).emit('updateChatMessage', {'username' : data[0], 'message' : data[2]});
      bd.putMessage(pg, {"message" : data[2], "username": data[0], "pista": data[1]}, function(message) {
          console.log(message);
      });

  });


});



//post data to DB | POST
// curut.post(function(req,res,next){

//     //validation
//     req.assert('name','Name is required').notEmpty();
//     req.assert('email','A valid email is required').isEmail();
//     req.assert('password','Enter a password 6 - 20').len(6,20);

//     var errors = req.validationErrors();
//     if(errors){
//         res.status(422).json(errors);
//         return;
//     }

//     //get data
//     var data = {
//         name:req.body.name,
//         email:req.body.email,
//         password:req.body.password
//      };

//     //inserting into mysql
//     req.getConnection(function (err, conn){

//         if (err) return next("Cannot Connect");

//         var query = conn.query("INSERT INTO t_user set ? ",data, function(err, rows){

//            if(err){
//                 console.log(err);
//                 return next("Mysql error, check your query");
//            }

//           res.sendStatus(200);

//         });

//      });

// });


// //now for Single route (GET,DELETE,PUT)
// var curut2 = router.route('/user/:user_id');

// /*------------------------------------------------------
// route.all is extremely useful. you can use it to do
// stuffs for specific routes. for example you need to do
// a validation everytime route /api/user/:user_id it hit.

// remove curut2.all() if you dont want it
// ------------------------------------------------------*/
// curut2.all(function(req,res,next){
//     console.log("You need to smth about curut2 Route ? Do it here");
//     console.log(req.params);
//     next();
// });

// //get data to update
// curut2.get(function(req,res,next){

//     var user_id = req.params.user_id;

//     req.getConnection(function(err,conn){

//         if (err) return next("Cannot Connect");

//         var query = conn.query("SELECT * FROM t_user WHERE user_id = ? ",[user_id],function(err,rows){

//             if(err){
//                 console.log(err);
//                 return next("Mysql error, check your query");
//             }

//             //if user not found
//             if(rows.length < 1)
//                 return res.send("User Not found");

//             res.render('edit',{title:"Edit user",data:rows});
//         });

//     });

// });

// //update data
// curut2.put(function(req,res,next){
//     var user_id = req.params.user_id;

//     //validation
//     req.assert('name','Name is required').notEmpty();
//     req.assert('email','A valid email is required').isEmail();
//     req.assert('password','Enter a password 6 - 20').len(6,20);

//     var errors = req.validationErrors();
//     if(errors){
//         res.status(422).json(errors);
//         return;
//     }

//     //get data
//     var data = {
//         name:req.body.name,
//         email:req.body.email,
//         password:req.body.password
//      };

//     //inserting into mysql
//     req.getConnection(function (err, conn){

//         if (err) return next("Cannot Connect");

//         var query = conn.query("UPDATE t_user set ? WHERE user_id = ? ",[data,user_id], function(err, rows){

//            if(err){
//                 console.log(err);
//                 return next("Mysql error, check your query");
//            }

//           res.sendStatus(200);

//         });

//      });

// });

// //delete data
// curut2.delete(function(req,res,next){

//     var user_id = req.params.user_id;

//      req.getConnection(function (err, conn) {

//         if (err) return next("Cannot Connect");

//         var query = conn.query("DELETE FROM t_user  WHERE user_id = ? ",[user_id], function(err, rows){

//              if(err){
//                 console.log(err);
//                 return next("Mysql error, check your query");
//              }

//              res.sendStatus(200);

//         });
//         //console.log(query.sql);

//      });
// });

//now we need to apply our router here
app.use('/api', router);

//start Server

