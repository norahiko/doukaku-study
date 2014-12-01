// 第2回 オフラインリアルタイムどう書くの問題
// 二値画像の回転
// http://qiita.com/Nabetani/items/9d80de41903775296ca6

"use strict";

function decode(hex) {
    return hex.replace(/./g, function(hx) {
        return ("000" + parseInt(hx, 16).toString(2)).slice(-4);
    });
}

function encode(bin) {
    return bin.replace(/.{1,4}/g, function(bn) {
        return parseInt((bn + "000").slice(0, 4), 2).toString(16);
    });
}

function rotateRight(size, bin) {
    var rotated = [];
    for(var y = 0; y < size; y++) {
        for(var x = 0; x < size; x++) {
            rotated[x * size + (size - 1 - y)] = bin[y * size + x];
        }
    }
    return rotated.join("");
}

function solve(input) {
    var sp = input.split(":");
    var bin = decode(sp[1]);
    return sp[0] + ":" + encode(rotateRight(sp[0], bin));
}

function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test("3:5b8"                  , "3:de0");
test("1:8"                    , "1:8");
test("2:8"                    , "2:4");
test("2:4"                    , "2:1");
test("2:1"                    , "2:2");
test("3:5d0"                  , "3:5d0");
test("4:1234"                 , "4:0865");
test("5:22a2a20"              , "5:22a2a20");
test("5:1234567"              , "5:25b0540");
test("6:123456789"            , "6:09cc196a6");
test("7:123456789abcd"        , "7:f1a206734b258");
test("7:fffffffffffff"        , "7:ffffffffffff8");
test("7:fdfbf7efdfbf0"        , "7:ffffffffffc00");
test("8:123456789abcdef1"     , "8:f0ccaaff78665580");
test("9:112233445566778899aab", "9:b23da9011d22daf005d40");
