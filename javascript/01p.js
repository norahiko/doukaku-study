// 第一回 オフラインリアルタイムどう書くの参考問題
// ポーカー
// http://qiita.com/Nabetani/items/cbc3af152ee3f50a822f
"use strict";

var hands = {
    "14444": "4K",
    "22333": "FH",
    "11333": "3K",
    "12222": "2P",
    "11122": "1P",
};


function solve(cards) {
    var counts = cards.match(/[0-9JQKA]+/g).map(function(num, _, nums) {
        return nums.filter(function(n) { return n === num }).length;
    });
    return hands[counts.sort().join("")] || "--";
}


function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test("S1S2S3S4S5", "--");
test("S1D1S2S3S4", "1P");
test("S1D1S2D2S3", "2P");
test("S1D1H1S2S3", "3K");
test("S1D1H1S2D2", "FH");
test("S1D1H1C1S2", "4K");
