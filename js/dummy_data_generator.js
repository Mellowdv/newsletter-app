const { faker } = require('@faker-js/faker');
var mysql = require('mysql')

var connection = mysql.createConnection({
    host    : 'localhost',
    user    : 'mellow',
    database: 'test_app'
});

connection.connect();
var userbase = 500;
var data = [];

for(var i = 0; i < userbase; i++)
{
    data.push([faker.internet.email(),faker.date.past()]);
}

connection.query('INSERT INTO users (email, created_at) VALUES ?', [data], function(error, result) {
    console.log(error);
    console.log(result);
})

connection.end();

