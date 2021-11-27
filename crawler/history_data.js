const puppeteer = require('puppeteer');
const muteRow = ["경기", "게임센터", "하이라이트", "TV", "라디오"];
const scoreBoard = "경기";

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
    await page.goto('https://www.koreabaseball.com/Schedule/Schedule.aspx?seriesId=1');
    await page.waitForNetworkIdle();
    //console.log(await page.$eval('#tblSchedule>thead',d => d.innerHTML));
    let titleNum = await page.$eval('#tblSchedule>thead>tr:nth-child(1)',d => d.childElementCount)
    let elementNum = await page.$eval('#tblSchedule>tbody',d => d.childElementCount)
    let temp = 0;
    let muted = [];
    let score = [0,"team1",0,"vs",0,"team2"];
    for (let i = 1; i < titleNum; i++) {
        const t = await page.$eval('#tblSchedule>thead>tr>th:nth-child('+i+')',d=>d.innerText);
        if (muteRow.includes(t)){
            muted[muted.length]=i;
        }
        if (t===scoreBoard)
            score[0]=i;
    }
    //console.log(muted)
    await page.waitForNetworkIdle();
    await page.waitForSelector('#tblSchedule>tbody>tr:nth-child('+elementNum+')>.play>span:nth-child(1)')
    for (let i = 1; i <= elementNum; i++) {

        let text=""
        score[2]=score[4]=null;
        score[1]=await page.$eval('#tblSchedule>tbody>tr:nth-child('+i+')>.play>span:nth-child(1)', d=>d.innerText)
        score[5]=await page.$eval('#tblSchedule>tbody>tr:nth-child('+i+')>.play>span:nth-child(3)', d=>d.innerText)
        if (await page.$eval('#tblSchedule>tbody>tr:nth-child('+i+')>.play>em', d=>d.childElementCount===3)){
            score[2]=await page.$eval('#tblSchedule>tbody>tr:nth-child('+i+')>.play>em>span:nth-child(1)', d=>d.innerText)
            score[4]=await page.$eval('#tblSchedule>tbody>tr:nth-child('+i+')>.play>em>span:nth-child(3)', d=>d.innerText)
        }

        if(await page.$eval('#tblSchedule>tbody>tr:nth-child('+i+')>td:nth-child(1)',d=>d.getAttribute('rowspan'))!==null)
            temp=i
        if(await page.$eval('#tblSchedule>tbody>tr:nth-child('+i+')',d => d.childElementCount)!==titleNum){
            text+=await page.$eval('#tblSchedule>tbody>tr:nth-child('+temp+')>td:nth-child(1)', d=>d.innerText)
            text+="\t"
            for (let j = 1; j <= titleNum-1; j++) {
                if (score[0]===j-1)text+=score[1]+"\t"+score[2]+"\t"+score[3]+"\t"+score[4]+"\t"+score[5]+"\t";
                if (muted.includes(j+1))continue;
                text+=await page.$eval('#tblSchedule>tbody>tr:nth-child('+i+')>td:nth-child('+j+')', d=>d.innerText)
                text+="\t"
            }
        } else {
            for (let j = 1; j <= titleNum; j++) {
                if (score[0]===j)text+=score[1]+"\t"+score[2]+"\t"+score[3]+"\t"+score[4]+"\t"+score[5]+"\t";
                if (muted.includes(j))continue;
                text += await page.$eval('#tblSchedule>tbody>tr:nth-child('+i+')>td:nth-child('+j+')', d=>d.innerText)
                text += "\t"
            }
        }
        console.log(text)
    }

    await page.goto('https://www.koreabaseball.com/Schedule/Schedule.aspx?seriesId=0');
    await page.waitForNetworkIdle();
    //console.log(await page.$eval('#tblSchedule>thead',d => d.innerHTML));
    titleNum = await page.$eval('#tblSchedule>thead>tr:nth-child(1)',d => d.childElementCount)
    elementNum = await page.$eval('#tblSchedule>tbody',d => d.childElementCount)
    temp = 0;
    muted = [];
    score = [0,"team1",0,"vs",0,"team2"];
    for (let i = 1; i < titleNum; i++) {
        const t = await page.$eval('#tblSchedule>thead>tr>th:nth-child('+i+')',d=>d.innerText);
        if (muteRow.includes(t)){
            muted[muted.length]=i;
        }
        if (t===scoreBoard)
            score[0]=i;
    }
    //console.log(muted)
    await page.waitForNetworkIdle();
    await page.waitForSelector('#tblSchedule>tbody>tr:nth-child('+elementNum+')>.play>span:nth-child(1)')
    for (let i = 1; i <= elementNum; i++) {

        let text=""
        score[2]=score[4]=null;
        score[1]=await page.$eval('#tblSchedule>tbody>tr:nth-child('+i+')>.play>span:nth-child(1)', d=>d.innerText)
        score[5]=await page.$eval('#tblSchedule>tbody>tr:nth-child('+i+')>.play>span:nth-child(3)', d=>d.innerText)
        if (await page.$eval('#tblSchedule>tbody>tr:nth-child('+i+')>.play>em', d=>d.childElementCount===3)){
            score[2]=await page.$eval('#tblSchedule>tbody>tr:nth-child('+i+')>.play>em>span:nth-child(1)', d=>d.innerText)
            score[4]=await page.$eval('#tblSchedule>tbody>tr:nth-child('+i+')>.play>em>span:nth-child(3)', d=>d.innerText)
        }

        if(await page.$eval('#tblSchedule>tbody>tr:nth-child('+i+')>td:nth-child(1)',d=>d.getAttribute('rowspan'))!==null)
            temp=i
        if(await page.$eval('#tblSchedule>tbody>tr:nth-child('+i+')',d => d.childElementCount)!==titleNum){
            text+=await page.$eval('#tblSchedule>tbody>tr:nth-child('+temp+')>td:nth-child(1)', d=>d.innerText)
            text+="\t"
            for (let j = 1; j <= titleNum-1; j++) {
                if (score[0]===j-1)text+=score[1]+"\t"+score[2]+"\t"+score[3]+"\t"+score[4]+"\t"+score[5]+"\t";
                if (muted.includes(j+1))continue;
                text+=await page.$eval('#tblSchedule>tbody>tr:nth-child('+i+')>td:nth-child('+j+')', d=>d.innerText)
                text+="\t"
            }
        } else {
            for (let j = 1; j <= titleNum; j++) {
                if (score[0]===j)text+=score[1]+"\t"+score[2]+"\t"+score[3]+"\t"+score[4]+"\t"+score[5]+"\t";
                if (muted.includes(j))continue;
                text += await page.$eval('#tblSchedule>tbody>tr:nth-child('+i+')>td:nth-child('+j+')', d=>d.innerText)
                text += "\t"
            }
        }
        console.log(text)
    }
    /*
    await page.goto('https://www.koreabaseball.com/Schedule/Schedule.aspx?seriesId=3,4,5,7');
    await page.waitForNetworkIdle();
    //console.log(await page.$eval('#tblSchedule>thead',d => d.innerHTML));
    titleNum = await page.$eval('#tblSchedule>thead>tr:nth-child(1)',d => d.childElementCount)
    elementNum = await page.$eval('#tblSchedule>tbody',d => d.childElementCount)
    temp = 0;
    muted = [];
    score = [0,"team1",0,"vs",0,"team2"];
    for (let i = 1; i < titleNum; i++) {
        const t = await page.$eval('#tblSchedule>thead>tr>th:nth-child('+i+')',d=>d.innerText);
        if (muteRow.includes(t)){
            muted[muted.length]=i;
        }
        if (t===scoreBoard)
            score[0]=i;
    }
    //console.log(muted)
    await page.waitForNetworkIdle();
    await page.waitForSelector('#tblSchedule>tbody>tr:nth-child('+elementNum+')>.play>span:nth-child(1)')
    for (let i = 1; i <= elementNum; i++) {
        for (const k in score) {
            score[k]=null;
        }

        let text=""
        score[5] = await page.$eval('#tblSchedule>tbody>tr:nth-child('+i+')>td:nth-child(9)', d=>d.innerText);
        if (score[5]==='이동일'){
            text += score[1] + "\t" + score[2] + "\t" + score[3] + "\t" + score[4] + "\t" + score[5] + "\t";
        } else {
            score[1] = await page.$eval('#tblSchedule>tbody>tr:nth-child(' + i + ')>.play>span:nth-child(1)', d => d.innerText);
            score[5] = await page.$eval('#tblSchedule>tbody>tr:nth-child(' + i + ')>.play>span:nth-child(3)', d => d.innerText);
            if (await page.$eval('#tblSchedule>tbody>tr:nth-child(' + i + ')>.play>em', d => d.childElementCount === 3)) {
                score[2] = await page.$eval('#tblSchedule>tbody>tr:nth-child(' + i + ')>.play>em>span:nth-child(1)', d => d.innerText);
                score[4] = await page.$eval('#tblSchedule>tbody>tr:nth-child(' + i + ')>.play>em>span:nth-child(3)', d => d.innerText);
            }

            if (await page.$eval('#tblSchedule>tbody>tr:nth-child(' + i + ')>td:nth-child(1)', d => d.getAttribute('rowspan')) !== null)
                temp = i
            if (await page.$eval('#tblSchedule>tbody>tr:nth-child(' + i + ')', d => d.childElementCount) !== titleNum) {
                text += await page.$eval('#tblSchedule>tbody>tr:nth-child(' + temp + ')>td:nth-child(1)', d => d.innerText);
                text += "\t"
                for (let j = 1; j <= titleNum - 1; j++) {
                    if (score[0] === j - 1) text += score[1] + "\t" + score[2] + "\t" + score[3] + "\t" + score[4] + "\t" + score[5] + "\t";
                    if (muted.includes(j + 1)) continue;
                    text += await page.$eval('#tblSchedule>tbody>tr:nth-child(' + i + ')>td:nth-child(' + j + ')', d => d.innerText);
                    text += "\t";
                }
            } else {
                for (let j = 1; j <= titleNum; j++) {
                    if (score[0] === j) text += score[1] + "\t" + score[2] + "\t" + score[3] + "\t" + score[4] + "\t" + score[5] + "\t";
                    if (muted.includes(j)) continue;
                    text += await page.$eval('#tblSchedule>tbody>tr:nth-child(' + i + ')>td:nth-child(' + j + ')', d => d.innerText)
                    text += "\t"
                }
            }
        }
        console.log(text);
    }
    */
    await browser.close();
})();