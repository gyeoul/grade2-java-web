const puppeteer = require('puppeteer');
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
    await page.screenshot({ path: 'example.png' });
    let data = await page.$$('#cphContents_cphContents_cphContents_udpRecord>.tData>tbody>tr');
    console.log(data);
    console.log("순위\t팀명\t경기\t승\t패\t무\t승률\t게임차\t최근10경기\t연속\t홈\t방문");
    for (let item of data) {
        let text = ""
        for (let i=1;i<=12;i++){
            text += await item.$eval('*:nth-child('+i+')',node => node.innerText);
            text += '\t';
        }
        console.log(text);
    }
    await browser.close();
})();