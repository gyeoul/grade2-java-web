const fs = require('fs');
const mysql = require('mysql');
const dbconnect  = {
    host: '211.193.44.86',
    port: '31022',
    user: 'dongyang',
    password: 'web',
    database: 'dongyang'
}
const conn = mysql.createConnection(dbconnect)

let bean = {}

function tagname(name) {
    let val = name;
    switch (name){
        case '삼미':
        case '청보':
        case '태평양':
        case '현대':
            val = 'HD';
            break;
        case '쌍방울':
            val = 'SB';
            break;
        case 'OB':
        case '두산':
            val = 'OB';
            break;
        case '해태':
        case 'KIA':
            val = 'HT';
            break;
        case 'LG':
        case 'MBC':
            val = 'LG';
            break;
        case '빙그레':
        case '한화':
            val = 'HH';
            break;
        case '히어로즈':
        case '넥센':
        case '우리':
        case '키움':
            val = 'WO';
            break;
        case '삼성':
            val = 'SS';
            break;
        case '롯데':
            val = 'LT';
            break;
        case 'SK':
        case 'SSG':
            val = 'SK';
            break;
        case 'NC':
            break;
        case 'KT':
            break;

    }
    return val;

}

const maxRow = 8;

const insertsql = 'INSERT INTO Schedule (id,date,away,home,awayScore,homeScore,stadium,note) VALUES(?,?,?,?,?,?,?,?)';
conn.connect();
conn.query('SELECT * FROM Schedule', function(err, results) {
    if (err) {
        console.log(err);
    }
    console.log(results);
});
for (let YEAR = 2010; YEAR <= 2021; YEAR++) {

    for (let MONTH = 3; MONTH < 12; MONTH++) {

        const file = fs.readFileSync('./ScheduleRaw_'+YEAR+'_'+MONTH+'.json',{encoding:"utf-8"},);
        const conv = JSON.parse(file)
        let temp = "";

        conv.rows.forEach(function (k) {
            bean = {
                date: '',
                homeTeam:'',
                homeScore:0,
                awayTeam:'',
                awayScore:0,
                stadium:'',
                cancelled:''
            }
            let data = [];

            if (k.row[maxRow]){
                temp=k.row[0].Text.split(/<[^>]*>/).filter(item => item);
            }
            k.row.forEach(function (t) {
                data[data.length] = t.Text.split(/<[^>]*>/).filter(item => item);
            });

            if (!data[maxRow]){
                data.unshift(temp);
            }

            //console.log(data);
            console.log(YEAR+'-'+data[0][0].split('(')[0].replace('\.','-')+'T'+data[1][0]+':00');
            bean.date = new Date(YEAR+'-'+data[0][0].split('(')[0].replace('\.','-')+'T'+data[1][0]+':00');
            bean.stadium = data[7][0]; bean.cancelled = data[8][0];
            bean.awayTeam = data[2][0];
            bean.homeTeam = data[2][3]?data[2][4]:data[2][2];
            bean.awayScore = data[2][3]?data[2][1]:null;
            bean.homeScore = data[2][3]?data[2][3]:null;
            const querydata = Number(bean.date)/100000+tagname(bean.awayTeam)+tagname(bean.homeTeam)+'\t'+bean.date.getFullYear()+'-'+(Number(bean.date.getMonth()+1)<10?"0"+Number(bean.date.getMonth()+1):Number(bean.date.getMonth()+1))+'-'+(bean.date.getDate()<10?"0"+bean.date.getDate():bean.date.getDate())+' '+(bean.date.getHours()<10?"0"+bean.date.getHours():bean.date.getHours())+':'+(bean.date.getMinutes()<10?"0"+bean.date.getMinutes():bean.date.getMinutes())+':'+(bean.date.getSeconds()<10?"0"+bean.date.getSeconds():bean.date.getSeconds())+'\t'+bean.awayTeam+'\t'+bean.homeTeam+'\t'
                +(bean.awayScore?bean.awayScore:0)+'\t'+(bean.homeScore?bean.homeScore:0)+'\t'+bean.stadium+'\t'+bean.cancelled;
            conn.query(insertsql,querydata.split('\t'),function (err, results) {
                if (err) {
                    if(err.code !== 'ER_DUP_ENTRY')
                        console.log(err);
                }
                console.log(results);
            })
            console.log(querydata)
            data = [];
        });

    }

}