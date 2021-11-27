const fs = require('fs');
let conv = {};
let text = "";
let maxrow = 0;
fs.readFile('./ScheduleRaw_2021_10.json',"utf-8",function (err,data){
    conv = JSON.parse(data)
    for (let k in conv.rows) {
        if (conv.rows[k].row.length < 9) text += (conv.rows[maxrow].row[0].Text).replace(/(<([^>]+)>)/ig,"") + '\t\t';
        else maxrow = k;
        for (let l in conv.rows[k].row) {
            text += (conv.rows[k].row[l].Text).split(/<[^>]*>/).filter(item=>item) + '\t\t';
        }
        console.log(text);
        text = "";
    }
})