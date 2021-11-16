const mysql = require('mysql');
const dbconnect  = {
    host: '211.193.44.86',
    port: '31022',
    user: 'dongyang',
    password: 'web',
    database: 'dongyang'
}
const connection = mysql.createConnection(dbconnect);
connection.connect();
connection.query("select * from test_member",function (err, results, fields) {
    if (err) {
        console.log(err);
    }
    console.log(results);
})
connection.end();