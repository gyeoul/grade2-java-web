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
    const browser = await puppeteer.launch({
        headless:false,
    });
    const page = await browser.newPage();
    await page.setViewport({
        width: 1920,
        height: 1080,
        deviceScaleFactor: 0.8,
    })
    await page.goto('https://www.koreabaseball.com/Player/Search.aspx');
    await page.waitForNetworkIdle();

    for (let k in teams) {
        await page.select('#cphContents_cphContents_cphContents_ddlTeam',`${k}`);
        await page.click('#cphContents_cphContents_cphContents_btnSearch',{delay:100});
        await page.waitForNetworkIdle();
        //await page.screenshot({path: 'example-'+`${teams[k]}`+'.png'});
        await page.waitForSelector('.tEx>tbody>tr>td');
        let num = Number(await page.$eval('.point',c => c.innerText));
        console.log(num);

        for (let i= 2; i<=Math.ceil(num/20.0); i++){
            try {
                await page.waitForSelector('.paging');
                await page.click('#cphContents_cphContents_cphContents_ucPager_btnNo'+i,{delay:100});
                await page.waitForNetworkIdle();
                //await page.screenshot({path: `${teams[k]}`+i+'.png'});
                let text =""
                for (let j = 1; j <= ((num-i*20)>20?20:(num-i*20)); j++) {
                    text = ""
                    text += await page.$eval('.tEx>tbody>tr:nth-child('+j+')>td>a',c=>c.href);
                    text = text.split('=')[1];
                    text += "\t";
                    for (let l = 1; l <= 7; l++) {
                        text += await page.$eval('.tEx>tbody>tr:nth-child('+j+')>td:nth-child('+l+')', c => c.innerText);
                        text += "\t";
                    }
                    text += await page.$eval('.tEx>tbody>tr:nth-child('+j+')>td>a',c=>c.href);
                    console.log(text);
                }
                await page.waitForTimeout(500);
            } catch (e) {
                console.log(e)
            }
        }

        /*
        for (let item in ds) {
            let text = ""
            for (let i = 0; i < 7; i++) {
                text += await item.$eval('*:nth-child('+i+')',c => c.innerHTML);
                text += '\t'
            }
            console.log(text)
        }

        for (let i= 2; i<=Math.ceil(num/20.0); i++){
            try {
                await page.waitForSelector('.paging');
                await page.click('#cphContents_cphContents_cphContents_ucPager_btnNo'+i,{delay:100});
                await page.waitForNetworkIdle();
                await page.screenshot({path: `${teams[k]}`+i+'.png'});
                await page.waitForTimeout(500);
            } catch (e) {
                console.log(e)
            }
        }
        */
    }
    await browser.close();
})();