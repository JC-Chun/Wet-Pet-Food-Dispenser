"use strict";

let obj = [{
    instantFeed: {
        now: 0,
        portion: 5
    },
    schedule: [{
        no: 1,
        time: "2020-03-05T17:00Z",
        portion: 2.500
    },
    {
        no: 2,
        time: "2020-03-06T07:30Z",
        portion: 3.125
    }
    ],
    history: [{
        no: 1,
        time: "2020-03-05T07:30Z",
        portion: 3.000
    },
    {
        no: 2,
        time: "2020-03-04T17:30Z",
        portion: 4.500
    }
    ]
}];

let fs = require('fs'),
    jsonData = JSON.stringify(obj);

fs.writeFile("./index.json", jsonData, function (err) {
    if (err) {
        console.log(err);
    }
})