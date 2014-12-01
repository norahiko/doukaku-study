// 第2回 オフラインリアルタイムどう書くの問題
// Bit Tetris
// http://nabetani.sakura.ne.jp/hena/ord2/


function solve(input) {
    var lines = input.match(/\w+/g).map(function(hex) { return parseInt(hex, 16) });
    var deleteLines = [0,1,2,3,4,5,6,7].map(function(i) {
        return lines.every(function(line) { return line & (1 << i) });
    });
    return lines.map(function(line) {
        var shift = 0;
        return [0,1,2,3,4,5,6,7].reduce(function(sum, n) {
            return deleteLines[n] ?  sum : sum + ((line & (1 << n) ? 1 : 0) << shift++);
        }, 0);
    }).map(function(line) {
        return ("0" + line.toString(16)).slice(-2);
    }).join("-");
}


function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test("ff-2f-23-f3-77-7f-3b"    , "1f-03-00-1c-0d-0f-06");
test("01"                      , "00");
test("00"                      , "00");
test("7a-4e"                   , "0c-02");
test("56-b6"                   , "08-14");
test("12-12-12"                , "00-00-00");
test("de-ff-7b"                , "0a-0f-05");
test("95-be-d0"                , "05-1e-20");
test("7c-b0-bb"                , "1c-20-2b");
test("7a-b6-31-6a"             , "3a-56-11-2a");
test("32-0e-23-82"             , "18-06-11-40");
test("ff-7f-bf-df-ef"          , "0f-07-0b-0d-0e");
test("75-df-dc-6e-42"          , "35-5f-5c-2e-02");
test("62-51-ef-c7-f8"          , "22-11-6f-47-78");
test("0c-47-8e-dd-5d-17"       , "04-23-46-6d-2d-0b");
test("aa-58-5b-6d-9f-1f"       , "52-28-2b-35-4f-0f");
test("ff-55-d5-75-5d-57"       , "0f-00-08-04-02-01");
test("fe-fd-fb-f7-ef-df-bf"    , "7e-7d-7b-77-6f-5f-3f");
test("fd-fb-f7-ef-df-bf-7f"    , "7e-7d-7b-77-6f-5f-3f");
test("d9-15-b5-d7-1b-9f-de"    , "69-05-55-67-0b-4f-6e");
test("38-15-fd-50-10-96-ba"    , "18-05-7d-20-00-46-5a");
test("fe-fd-fb-f7-ef-df-bf-7f" , "fe-fd-fb-f7-ef-df-bf-7f");
