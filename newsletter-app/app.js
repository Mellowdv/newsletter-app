var express = require('express');
var app = express();
var mysql = require('mysql');
var ejs = require('ejs');
var bodyParser = require('body-parser');

app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({extended: true}));
app.use(express.static(__dirname + '/public'));

var connection = mysql.createConnection({
    host    : 'localhost',
    user    : 'mellow',
    database: 'test_app'
});

app.get("/", function(req, res) {
    connection.query('SELECT COUNT(*) AS count FROM users;', function(error, result) {
        if (error) throw error;
        var count = result[0].count;
        res.render('home', {data: count});
    });
});

app.get("/joke", function(req, res) {
    var joke = 'Your mom.';
    res.send(joke);
});

app.get("/user_stats", function(req, res) {
    connection.query('SELECT COUNT(*) AS count FROM users;', function(error, result) {
        if (error) throw error;
        console.log(result);
        var count = result[0].count;
        res.send('There are ' + count + ' users in the database. :)');
    });
});

app.post("/register", function(req, res) {
    var person = {
        email: req.body.email
    };
    connection.query('INSERT INTO users SET ?', person, function(error, result) {
        if (error) throw error;
        res.redirect("/");
    });
});

app.listen(8080, function() {
    console.log('App listening on port 8080');
});
