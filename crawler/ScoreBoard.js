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

(async () => {
    const browser = await puppeteer.launch({
        headless: false,
    });
    const page = await browser.newPage();
    await page.setViewport({
        width: 1920,
        height: 1080,
        deviceScaleFactor: 1,
    })
    await page.goto('https://www.koreabaseball.com/Schedule/ScoreBoard.aspx');
    let whilecount = year_now;
    while (whilecount===year_now) {
        await page.waitForSelector('#contents');
        await page.waitForNetworkIdle();
        let tDate = (await page.$eval('#cphContents_cphContents_cphContents_lblGameDate', t => t.innerHTML)).split('.');
        let tablelen = await page.$$eval('#cphContents_cphContents_cphContents_udpRecord>div>table>tbody>tr',(tr)=>tr.length);
        if (tablelen > 1) {
            let scoreBoardCount=await page.$$eval('.smsScore',(p)=>p.length);
            for (let i = 1; i <= scoreBoardCount; i++) {
                let str = '#cphContents_cphContents_cphContents_udpRecord > div:nth-child('+(i+1)+')';
                const away = await page.$eval(str + ' > div.score_wrap > p.leftTeam > strong',t=>t.innerHTML);
                const awayScore = await page.$eval(str + ' > div.score_wrap > p.leftTeam > em > span',t=>t.innerHTML);
                const home = await page.$eval(str + ' > div.score_wrap > p.rightTeam > strong',t=>t.innerHTML);
                const homeScore = await page.$eval(str + ' > div.score_wrap > p.rightTeam > em > span',t=>t.innerHTML);
                const stadium = (await page.$eval(str + ' > p.place', t => t.innerHTML)).split('<span>')[0];

                const tTime = (await page.$eval(str + ' > p.place > span', t => t.innerHTML)).split(':');
                const itDate = new Date(Number(tDate[0].slice(0,4)),Number(tDate[1])-1,Number(tDate[2].slice(0,2)),Number(tTime[0]),Number(tTime[1]),0);

                console.log(Number(itDate)/100000+tagname(away)+tagname(home)+'\t'
                    +away.slice(0,3)+'\t'+awayScore+'\t'+homeScore+'\t'+home.slice(0,3)+'\t'+stadium+itDate);
            }
        }
        whilecount = parseInt(tDate[0]);
        await page.click('.date-select>.date>.prev>a');
    }
    await browser.close();
})();