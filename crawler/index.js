const puppeteer = require('puppeteer');
const mysql = require('mysql');
const dbconnect  = {
    host: '211.193.44.86',
    port: '31022',
    user: 'dongyang',
    password: 'web',
    database: 'dongyang'
}
const KBLFY = 1982;//한국 야구 리그 원년
const year_now = new Date().getFullYear();
const teams = {
    'NC' : 'NC',
    'OB' : '두산',
    'KT' : 'KT',
    'LG' : 'LG',
    'WO' : '키움',
    'HT' : 'KIA',
    'LT' : '롯데',
    'SS' : '삼성',
    'SK' : 'SSG',
    'HH' : '한화',
};
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

    }
    return val;

}

(async () => {
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
    console.log("ID\tYear\tRank\tTeam\t경기\tW\tL\tD\t승률\t게임차\t최근10경기\t연속\t홈\t방문");
    await page.select('#cphContents_cphContents_cphContents_ddlYear', );

    for (let c_year = year_now-1; c_year >= KBLFY; c_year--) {
        //await page.select('#cphContents_cphContents_cphContents_ddlYear', toString(c_year));
        //await page.select('#cphContents_cphContents_cphContents_ddlSeries', '정규시즌');
        await page.select('#cphContents_cphContents_cphContents_ddlYear', `${c_year}`);
        await page.click('.select01');
        await page.waitForTimeout(1000);
        await page.keyboard.press('Enter');
        await page.waitForNetworkIdle();
        await page.waitForSelector('#cphContents_cphContents_cphContents_udpRecord>.tData>tbody>tr');
        data = await page.$$('#cphContents_cphContents_cphContents_udpRecord>.tData>tbody>tr');
        for (let item of data) {
            let text = "";
            text += c_year + tagname(await item.$eval('*:nth-child(2)',n => n.innerText)) + '\t' + c_year + '\t';
            for (let i=1;i<=12;i++){
                text += await item.$eval('*:nth-child('+i+')',node => node.innerText) + '\t';
            }
            console.log(text);
        }
    }
    await browser.close();
})();