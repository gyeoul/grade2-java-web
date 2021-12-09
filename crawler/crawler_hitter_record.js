const puppeteer = require("puppeteer");

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


//순위    선수명  팀명    AVG (타율)      G (경기)        PA (타석)       AB (타수)       R (득점)        H (안타)        2B (2루타)      3B (3루타)      HR (홈런)       TB (루타)       RBI (타점)      SAC (희생번트)  SF (희생플라이)
//                                       BB (볼넷)       IBB (고의4구)   HBP (사구)      SO (삼진)       GDP (병살타)    SLG (장타율)    OBP (출율)     OPS (출루율+장타율)     MH (멀티히트)   RISP (득점권타율)       PH-BA (대타타율)

//await page.goto('https://www.koreabaseball.com/Record/Player/PitcherBasic/Basic1.aspx');
//await page.goto("https://www.koreabaseball.com/Record/Player/Defense/Basic.aspx");
//await page.goto("https://www.koreabaseball.com/Record/Player/Runner/Basic.aspx");

let playerArray = [];

(async () => {
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


    await page.select('#cphContents_cphContents_cphContents_ddlSeries_ddlSeries', '0');
    await page.waitForNetworkIdle();
    await page.waitForSelector('#cphContents_cphContents_cphContents_udpContent > div.row > div.more_record > span');
    let teamsArray = await page.$$('#cphContents_cphContents_cphContents_ddlTeam_ddlTeam > option');


    for (let i = 1; i < teamsArray.length; i++) { //teamsArray.length
        console.log(tagname(await page.evaluate((x) => x.innerHTML, teamsArray[i])));

        await page.select('#cphContents_cphContents_cphContents_ddlTeam_ddlTeam', tagname(await page.evaluate((x) => x.innerHTML, teamsArray[i])));
        await page.waitForSelector('#cphContents_cphContents_cphContents_ddlTeam_ddlTeam');
        await page.waitForNetworkIdle();
        await page.waitForSelector('#cphContents_cphContents_cphContents_udpContent > div.row > div.more_record > span');

        const pageCount = (await page.$$('#cphContents_cphContents_cphContents_udpContent > div.record_result > div > a')).length - 2;
        console.log(pageCount);

        playerArray = [pageCount * 30]
        for (let j = 0; j < pageCount * 30; j++) {
            playerArray[j] = {};
        }

        for (let j = 0; j < pageCount; j++) {
            await page.click('#cphContents_cphContents_cphContents_udpContent > div.record_result > div > a:nth-child(' + parseInt(j / 2 + 1) + ')');
            await page.waitForNetworkIdle();
            await page.waitForSelector('#cphContents_cphContents_cphContents_udpContent > div.row > div.more_record > span');

            let thsArray = await page.$$('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > thead > tr > th');
            let trsArray = await page.$$('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr');
            console.log('trsArray:' + trsArray.length)

            for (let k = 0; k < trsArray.length; k++) {
                let text = (await page.$eval('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr:nth-child(' + (k + 1) + ') > td:nth-child(2) > a', x => x.href)).split("=")[1] + '\t';
                playerArray[j + k]['ID'] = (await page.$eval('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr:nth-child(' + (k + 1) + ') > td:nth-child(2) > a', x => x.href)).split("=")[1];
                for (let l = 0; l < thsArray.length; l++) {
                    text += await page.$eval('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr:nth-child(' + (k + 1) + ') > td:nth-child(' + (l + 1) + ')', x => x.innerText);
                    text += '\t';
                    playerArray[j + k][await page.$eval('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > thead > tr > th:nth-child(' + (l + 1) + ')', x => x.innerText)] =
                        await page.$eval('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr:nth-child(' + (k + 1) + ') > td:nth-child(' + (l + 1) + ')', x => x.innerText);
                }
                console.log(text);
            }


            await page.click('#cphContents_cphContents_cphContents_udpContent > div.row > div.more_record > a.next');
            await page.waitForNetworkIdle();
            await page.waitForSelector('#cphContents_cphContents_cphContents_udpContent > div.row > div.more_record > span');

            thsArray = await page.$$('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > thead > tr > th');
            trsArray = await page.$$('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr');
            console.log('trsArray:' + trsArray.length)

            for (let k = 0; k < trsArray.length; k++) {
                let text = (await page.$eval('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr:nth-child(' + (k + 1) + ') > td:nth-child(2) > a', x => x.href)).split("=")[1] + '\t';
                playerArray[j + k]['ID'] = (await page.$eval('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr:nth-child(' + (k + 1) + ') > td:nth-child(2) > a', x => x.href)).split("=")[1];
                for (let l = 0; l < thsArray.length; l++) {
                    text += await page.$eval('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr:nth-child(' + (k + 1) + ') > td:nth-child(' + (l + 1) + ')', x => x.innerText);
                    text += '\t';
                    playerArray[j + k][await page.$eval('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > thead > tr > th:nth-child(' + (l + 1) + ')', x => x.innerText)] =
                        await page.$eval('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr:nth-child(' + (k + 1) + ') > td:nth-child(' + (l + 1) + ')', x => x.innerText);
                }
                console.log(text);
            }

        }
        console.log(playerArray)
        //for (let j = 0; j < playerArray.filter(function (el) {return el.ID != null}).length; j++) {
        //    console.log(playerArray[j])
        //}
        teamsArray = await page.$$('#cphContents_cphContents_cphContents_ddlTeam_ddlTeam > option');
    }
    await browser.close();
})();

/*
for (let j = 1; j <= pageCount*2; j++) {
            if (j%2===0){
                await page.click('#cphContents_cphContents_cphContents_udpContent > div.row > div.more_record > a.next');
            } else {
                await page.click('#cphContents_cphContents_cphContents_udpContent > div.record_result > div > a:nth-child('+parseInt(j/2+1)+')');
            }
            await page.waitForNetworkIdle();
            await page.waitForSelector('#cphContents_cphContents_cphContents_udpContent > div.row > div.more_record > span');


            const thsArray = await page.$$('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > thead > tr > th');
            const trsArray = await page.$$('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr');
            console.log('trsArray:'+ trsArray.length)

            for (let k = 0; k < trsArray.length; k++) {
                let text = (await page.$eval('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr:nth-child('+(k+1)+') > td:nth-child(2) > a',x=>x.href)).split("=")[1] + '\t';
                playerArray[k+(j%2)%pageCount*30]['ID'] = (await page.$eval('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr:nth-child('+(k+1)+') > td:nth-child(2) > a',x=>x.href)).split("=")[1];
                for (let l = 0; l < thsArray.length; l++) {
                    text += await page.$eval('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr:nth-child('+(k+1)+') > td:nth-child('+(l+1)+')',x=>x.innerText);
                    text += '\t';
                    playerArray[k+(j%2)%pageCount*30][await page.$eval('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > thead > tr > th:nth-child('+(l+1)+')',x=>x.innerText)] =
                        await page.$eval('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr:nth-child('+(k+1)+') > td:nth-child('+(l+1)+')',x=>x.innerText);
                }
                console.log(text);
                if (j%2 > pageCount){
                    console.log(playerArray[k+(j%2)*30]);
                }
            }
        }

 */


/*





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

    for (let i = 1; i < 4; i++) {
        headtitle = await page.$eval(sel.record_result+' > thead > tr > th:nth-child(' +i+')', x=>x.innerText);
        head1Json[headtitle] = "";
    }
    head1Json.d= [{},{}];

    for (let i = 4; i <= n.length; i++) {
        selector = await page.$(sel.record_result+' > thead > tr > th:nth-child('+i+')');
        temp2 = await selector.$eval('a',x=>x.innerHTML);
        head1Json.d[0][temp2] = "";
    }
    let temp1 = await page.$$('.paging > a')
    console.log(temp1.length-2);

    await page.click('#cphContents_cphContents_cphContents_udpContent > div.row > div.more_record > a.next');
    await page.waitForNetworkIdle();
    await page.waitForSelector('#cphContents_cphContents_cphContents_udpContent > div.record_result > table');

    n = await page.$$('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > thead > tr > th');
    for (let i = 4; i <= n.length; i++) {
        selector = await page.$(sel.record_result+' > thead > tr > th:nth-child('+i+')');
        temp2 = await selector.$eval('a',x=>x.innerHTML);
        head1Json.d[1][temp2] = "";
    }
    console.log(head1Json);




    await page.click('#cphContents_cphContents_cphContents_udpContent > div.row > div.more_record > a.prev');
    await page.waitForNetworkIdle();
    await page.waitForSelector('#cphContents_cphContents_cphContents_udpContent > div.record_result > table');

    for (let i = 0; i < temp1.length-2; i++) {
        let temp3 = await page.$$('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr');
        for (let j = 1; j <= temp3.length; j++) {
            await page.$eval('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr:nth-child('+j+')',x=>x.innerHTML);
            jsonArray[(j+i*30)] = head1Json;

            for (const k in Object.keys(jsonArray[(j+i*30)])) {
                jsonArray[(j+i*30)][k] = await page.$eval();
            }

            let counttd = await page.$$('#cphContents_cphContents_cphContents_udpContent > div.record_result > table > tbody > tr:nth-child('+j+') > td > a');

            console.log(Object.keys(jsonArray[(j+i*30)]) + " " + counttd.length + " " + (j+i*30));

            for (const k in Object.keys(jsonArray[(j+i*30)].d[0])) {
                jsonArray[(j+i*30)].d[0][ Object.keys(jsonArray[(j+i*30)])[(parseInt(k))] ] = await page.$eval('#cphContents_cphContents_cphContents_udpContent > div.record_result > ' +
                    'table > tbody > tr:nth-child('+j+') > td:nth-child('+(parseInt(k)+parseInt(1))+')', x=>x.innerText);
            }
            console.log(jsonArray[(j+i*30)]);
        }
    }

    await browser.close();
})();

*/