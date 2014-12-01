// オフラインリアルタイムどう書く第三回の参考問題
// ボールカウント(野球)
// http://qiita.com/Nabetani/items/ebd8a56b41711ba459f9

"use strict";

function solve(input) {
    var bb = [0, 0, 0];     // [out, strike, ball]
    return input.split("").map(function(event) {
        if(event === "b") {
            bb[2]++;
        } else if(event === "s" || (event === "f" && bb[1] !== 2)) {
            bb[1]++;
        } else if(event === "h") {
            bb = [bb[0], 0, 0];
        } else if(event === "p") {
            bb = [bb[0]+1, 0, 0];
        }

        if(bb[2] === 4) {
            bb = [bb[0], 0, 0];
        }
        if(bb[1] === 3) {
            bb = [bb[0]+1, 0, 0];
        }
        if(bb[0] === 3) {
            bb = [0, 0, 0];
        }
        return bb.join("");
    }).join(",");
}

function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test("s"              , "010");
test("sss"            , "010,020,100");
test("bbbb"           , "001,002,003,000");
test("ssbbbb"         , "010,020,021,022,023,000");
test("hsbhfhbh"       , "000,010,011,000,010,000,001,000");
test("psbpfpbp"       , "100,110,111,200,210,000,001,100");
test("ppp"            , "100,200,000");
test("ffffs"          , "010,020,020,020,100");
test("ssspfffs"       , "010,020,100,200,210,220,220,000");
test("bbbsfbppp"      , "001,002,003,013,023,000,100,200,000");
test("sssbbbbsbhsbppp", "010,020,100,101,102,103,100,110,111,100,110,111,200,000,100");
test("ssffpffssp"     , "010,020,020,020,100,110,120,200,210,000");
