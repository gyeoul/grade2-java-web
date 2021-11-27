const fetch = require('cross-fetch');
const fs = require('fs');
const KBLFY = 1982;//한국 야구 리그 원년

fetch("https://www.koreabaseball.com/ws/Schedule.asmx/GetScheduleList", {
    "headers": {
        "accept": "application/json, text/javascript, */*; q=0.01",
        "accept-language": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7",
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
        "x-requested-with": "XMLHttpRequest",
        "Referer": "https://www.koreabaseball.com/Schedule/Schedule.aspx?seriesId=0,9",
        "Referrer-Policy": "strict-origin-when-cross-origin"
    },
    "body": "leId=1&srIdList=0%2C9&seasonId=2021&gameMonth=10&teamId=",
    "method": "POST"
}).then((res)=>{
    res.json().then((d)=>{
        if (d.error) {
            console.log(d.error)
        } else {
            fs.writeFileSync('./ScheduleRaw.json',JSON.stringify(d),'utf-8')
        }
    })
});


async function ScheduleFetcher(year,month) {
    let response = await fetch("https://www.koreabaseball.com/ws/Schedule.asmx/GetScheduleList", {
        "headers": {
            "accept": "application/json, text/javascript, */*; q=0.01",
            "accept-language": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7",
            "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
            "x-requested-with": "XMLHttpRequest",
            "Referer": "https://www.koreabaseball.com/Schedule/Schedule.aspx?seriesId=0,9",
            "Referrer-Policy": "strict-origin-when-cross-origin"
        },
        "body": "leId=1&srIdList=0%2C9&seasonId="+year+"&gameMonth="+month+"&teamId=",
        "method": "POST"
    });
    let rd = await response.json();
    await fs.writeFileSync('./ScheduleRaw_'+year+'_'+month+'.json',JSON.stringify(rd),'utf-8');
}

for (let i = new Date().getFullYear(); i >= KBLFY; i--) {
    for (let j = 3; j <= 3; j++) {
        ScheduleFetcher(i,j).catch(e => {
            console.log('There has been a problem with your fetch operation: ' + e.message);
        });
    }
}