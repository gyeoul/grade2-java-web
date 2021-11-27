const fetch=require('cross-fetch');

fetch("https://www.koreabaseball.com/ws/Schedule.asmx/GetStadiumWeekly", {

    "headers": {
        "accept": "application/json, text/javascript, */*; q=0.01",
        "accept-language": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7",
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8"  },
    "body": "stadium=GC",
    "method": "POST"
}).then((res)=>{
    res.json().then((d)=>{
        if (d.error) {
            console.log(d.error)
        } else {
            console.log(d)
        }
    })
})

fetch("https://www.koreabaseball.com/ws/Schedule.asmx/GetScheduleList", {
    "headers": {
        "accept": "application/json, text/javascript, */*; q=0.01",
        "accept-language": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7",
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
        "Referer": "https://www.koreabaseball.com/Schedule/Schedule.aspx",
        "Referrer-Policy": "strict-origin-when-cross-origin"
    },
    "body": "leId=1&srIdList=3%2C4%2C5%2C7&seasonId=2021&gameMonth=&teamId=",
    "method": "POST"
});

fetch("https://www.koreabaseball.com/ws/Schedule.asmx/GetScheduleList", {
    "headers": {
        "accept": "application/json, text/javascript, */*; q=0.01",
        "accept-language": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7",
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
        "x-requested-with": "XMLHttpRequest",
        "Referer": "https://www.koreabaseball.com/Schedule/Schedule.aspx?seriesId=0,9",
        "Referrer-Policy": "strict-origin-when-cross-origin"
    },
    "body": "leId=1&srIdList=0%2C9&seasonId=2021&gameMonth=&teamId=",
    "method": "POST"
}).then((res)=>{
    res.json().then((d)=>{
        if (d.error) {
            console.log(d.error)
        } else {
            console.log(d)
        }
    })
});