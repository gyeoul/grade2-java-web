const puppeteer = require('puppeteer');
const mysql = require('mysql');
const dbconnect  = {
    host: '211.193.44.86',
    port: '31022',
    user: 'dongyang',
    password: 'web',
    database: 'dongyang'
}
const conn = mysql.createConnection(dbconnect)
const KBLFY = 1982;//한국 야구 리그 원년
const year_now = new Date().getFullYear();
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
let querysql = 'INSERT INTO TeamRank (ID,YEAR,`RANK`,TEAM,GAMES,WIN,LOSE,DRAW,RATE,GAP,LAST,STRAIGHT,HOME,AWAY) VALUES(?,?)';

(async () => {
    conn.connect();
    conn.query('SELECT * FROM TeamRank', function(err, results) {
        if (err) {
            console.log(err);
        }
        console.log(results);
    });

    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.setViewport({
        width: 1920,
        height: 1080,
        deviceScaleFactor: 1,
    })
    await page.goto('https://www.koreabaseball.com/TeamRank/TeamRank.aspx');
    await page.waitForSelector('#contents');
    let data = await page.$$('#cphContents_cphContents_cphContents_udpRecord>.tData>tbody>tr');
    console.log("ID\tYear\tRank\tTeam\tGames\tW\tL\tD\tRate\tGap\tLast10\tStraight\tHome\tAway");
    await page.select('#cphContents_cphContents_cphContents_ddlYear', );

    for (let c_year = year_now; c_year > KBLFY; c_year--) {
        await page.select('#cphContents_cphContents_cphContents_ddlYear', `${c_year}`);
        await page.waitForTimeout(1000);
        await page.click('.select01');
        await page.waitForTimeout(1000);
        await page.keyboard.press('Enter');
        await page.waitForNetworkIdle();
        await page.waitForSelector('#cphContents_cphContents_cphContents_udpRecord>.tData>tbody>tr');
        data = await page.$$('#cphContents_cphContents_cphContents_udpRecord>.tData>tbody>tr');
        for (let item of data) {
            let id = c_year + tagname(await item.$eval('*:nth-child(2)',n => n.innerText));
            let text = "";
            text += c_year + '\t';
            for (let i=1;i<=12;i++){
                text += await item.$eval('*:nth-child('+i+')',node => node.innerText) + '\t';
            }
            console.log(text);
            conn.query(querysql, [id,text.split('\t',13)], function(err, results) {
                if (err) {
                    console.log(err);
                    if (c_year === year_now) {
                        const updatequery = 'UPDATE TeamRank Set YEAR=?, `RANK`=?, TEAM=?, GAMES=?, WIN=?, LOSE=?, DRAW=?, RATE=?, GAP=?, LAST=?, STRAIGHT=?, HOME=?, AWAY=? WHERE ID=?'
                        conn.query(updatequery, [text.split('\t',text.length-1),id], function (err, results) {
                            if (err) {
                                console.log(err);
                            }
                            console.log(results);
                        });
                    }
                }
                console.log(results);
            });
        }
    }
    await browser.close();
})();
