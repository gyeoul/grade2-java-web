const puppeteer = require("puppeteer");
const mysql = require('mysql');
const dbconnect = {
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
    switch (name) {
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

let querysql = "";

let selector;

let jsonArray = [{}];
let tempJson = {};
let headJson = {};
//순위    선수명  팀명    AVG (타율)      G (경기)        PA (타석)       AB (타수)       R (득점)        H (안타)        2B (2루타)      3B (3루타)      HR (홈런)       TB (루타)       RBI (타점)      SAC (희생번트)  SF (희생플라이)
//                                       BB (볼넷)       IBB (고의4구)   HBP (사구)      SO (삼진)       GDP (병살타)    SLG (장타율)    OBP (출율)     OPS (출루율+장타율)     MH (멀티히트)   RISP (득점권타율)       PH-BA (대타타율)

//await page.goto('https://www.koreabaseball.com/Record/Player/PitcherBasic/Basic1.aspx');
//await page.goto("https://www.koreabaseball.com/Record/Player/Defense/Basic.aspx");
//await page.goto("https://www.koreabaseball.com/Record/Player/Runner/Basic.aspx");
const sel = {
    record_result: "#cphContents_cphContents_cphContents_udpContent > div.record_result > table",
};
(async () => {

    let temp2 = "";

    const browser = await puppeteer.launch({
        headless: false
    });
    const page = await browser.newPage();
    await page.setViewport({
        width: 1920,
        height: 1080,
        deviceScaleFactor: 1,
    });
    await page.goto('https://www.koreabaseball.com/Record/Player/HitterBasic/BasicOld.aspx?sort=HRA_RT');
    await page.waitForNetworkIdle();
    await page.waitForSelector('#cphContents_cphContents_cphContents_udpContent > div.record_result > table');


    await page.select('#cphContents_cphContents_cphContents_ddlSeries_ddlSeries','0');
    await page.waitForNetworkIdle();
    await page.waitForSelector('#cphContents_cphContents_cphContents_udpContent > div.row > div.more_record > span');

    let n = await page.$$('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > thead > tr > th');
    for (let i = 1; i <= n.length; i++) {
        if (i<=3){
            temp2 = await page.$eval(sel.record_result+' > thead > tr > th:nth-child(' +i+')', x=>x.innerText);
        } else {
            selector = await page.$(sel.record_result+' > thead > tr > th:nth-child('+i+')');
            temp2 = await selector.$eval('a',x=>x.innerHTML);
        }
        headJson[temp2] = "";
    }
    let temp1 = await page.$$('.paging > a')
    console.log(temp1.length-2);

    await page.click('#cphContents_cphContents_cphContents_udpContent > div.row > div.more_record > a.next');
    await page.waitForNetworkIdle();
    await page.waitForSelector('#cphContents_cphContents_cphContents_udpContent > div.record_result > table');

    n = await page.$$('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > thead > tr > th');
    for (let i = 5; i <= n.length; i++) {
        selector = await page.$(sel.record_result+' > thead > tr > th:nth-child('+i+')');
        temp2 = await selector.$eval('a',x=>x.innerHTML);
        headJson[temp2] = "";
    }
    console.log(headJson);

    await page.click('#cphContents_cphContents_cphContents_udpContent > div.row > div.more_record > a.prev');
    await page.waitForNetworkIdle();
    await page.waitForSelector('#cphContents_cphContents_cphContents_udpContent > div.record_result > table');

    for (let i = 0; i < temp1.length-2; i++) {
        let temp3 = await page.$$('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr');
        for (let j = 1; j <= temp3.length; j++) {
            await page.$eval('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr:nth-child('+j+')',x=>x.innerHTML);
            jsonArray[(j+i*30)] = headJson;
            let counttd = await page.$$('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr:nth-child('+(j+i*30)+') > td');

            console.log(Object.keys(jsonArray[(j+i*30)]) + " " + counttd.length);

            for (const k in Object.keys(jsonArray[(j+i*30)])) {
                jsonArray[(j+i*30)][(parseInt(k))]=await page.$eval('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr:nth-child('+(j+i*30)+') > td:nth-child('+(parseInt(k)+parseInt(1))+')', x=>x.innerHTML);
                console.log(k + jsonArray[(j+i*30)][k]);
            }
            console.log(jsonArray[(j+i*30)]);
        }
    }

    await browser.close();
})();

