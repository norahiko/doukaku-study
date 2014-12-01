"use strict";

var mapData = [
    "!!!TUVW".split(""),
    "!!kHIJX".split(""),
    "!jSBCKY".split(""),
    "iRGADLZ".split(""),
    "hQFEMa!".split(""),
    "gPONb!!".split(""),
    "fedc!!!".split("")
];

var vecs = {
    0: [0, -1],
    1: [1, -1],
    2: [1, 0],
    3: [0, 1],
    4: [-1, 1],
    5: [-1, 0],
};

function solve(input) {
    var result = "A";
    var pos = [3, 3];

    for(var i = 0; i < input.length; i++) {
        var dir = input[i];
        var nx = pos[0] + vecs[dir][0];
        var ny = pos[1] + vecs[dir][1];

        if(0 <= nx && nx < mapData[0].length &&
                0 <= ny && ny < mapData.length && mapData[ny][nx] !== "!") {
            result += mapData[ny][nx];
            pos = [nx, ny];
        } else {
            result += "!";
        }
    }
    return result;
}


function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test("135004"     , "ACDABHS");
test("1"          , "AC");
test("33333120"   , "AENc!!b!M");
test("0"          , "AB");
test("2"          , "AD");
test("3"          , "AE");
test("4"          , "AF");
test("5"          , "AG");
test("4532120"    , "AFQPOEMD");
test("051455"     , "ABSHSj!");
test("23334551"   , "ADMb!cdeO");
test("22033251"   , "ADLKLa!ML");
test("50511302122", "AGSjkTHTU!VW");
test("000051"     , "ABHT!!!");
test("1310105"    , "ACDKJW!V");
test("50002103140", "AGSk!HU!IVIU");
test("3112045"    , "AEDKYXKC");
test("02021245535", "ABCIJW!JIHBS");
test("014204"     , "ABIBCIB");
test("255230"     , "ADAGAEA");
test("443501"     , "AFPefgQ");
test("022321"     , "ABCKLZ!");
test("554452"     , "AGRh!!Q");
test("051024"     , "ABSHTUH");
test("524002"     , "AGAFGSB");
test("54002441132", "AGQRjSRhRSGA");
test("11010554312", "ACJV!!UTkSHI");
test("23405300554", "ADMNEFOFGRi!");
test("555353201"  , "AGRih!gPQG");
test("22424105"   , "ADLMabaLD");
test("11340202125", "ACJKDCKJX!!J");
test("4524451"    , "AFQFPf!P");
test("44434234050", "AFPf!!e!!Pgh");
test("00554040132", "ABHk!j!i!jRG");
test("3440403"    , "AEOePfgf");
test("111130"     , "ACJW!XW");
test("21133343125", "ADKXYZ!a!Z!L");
test("353511"     , "AEFOPFA");
test("22204115220", "ADLZYLY!KY!X");
test("03013541"   , "ABABICBGB");
test("101344"     , "ACIVJCA");
test("2432541"    , "ADENbNdN");
test("45332242015", "AFQPedc!!NME");
test("215453"     , "ADKCAGF");
test("45540523454", "AFQh!i!RQg!!");
test("42434302545", "AFEOd!!ONOef");
