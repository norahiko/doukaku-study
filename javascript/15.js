"use strict";

var runeData = [
    ["0"  , "" ],
    ["131", "T"],
    ["323", "U"],
    ["313", "N"],
    ["231", "S"],
    ["132", "Z"],
    ["32" , "L"],
    ["31" , "R"],
    ["23" , "J"],
];

String.prototype.startsWith = function(prefix) {
    return prefix === this.slice(0, prefix.length);
};

function hexToBin(hex) {
    return hex.split("").map(function(h) {
        return ("000" + parseInt(h, 16).toString(2)).slice(-4);
    }).join("");
}

function parse(input) {
    var upper = hexToBin(input.split("/")[0]);
    var lower = hexToBin(input.split("/")[1]);
    return upper.split("").map(function(_, i) {
        return Number(upper[i]) + Number(lower[i]) * 2;
    }).join("");
}


function solve(input) {
    var board  = parse(input);
    var result = "";

    while(board) {
        for(var i = 0; i < runeData.length; i++) {
            if(board.startsWith(runeData[i][0])) {
                result += runeData[i][1];
                board = board.slice(runeData[i][0].length);
                break;
            }
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

test( "2ed8aeed/34b0ea5b", "LTRSUNTSJ" );
test( "00000200/00000300", "L" );
test( "00018000/00010000", "R" );
test( "00002000/00006000", "J" );
test( "00000700/00000200", "T" );
test( "01400000/01c00000", "U" );
test( "00003800/00002800", "N" );
test( "000c0000/00180000", "S" );
test( "00003000/00001800", "Z" );
test( "132eae6c/1a64eac6", "LRJTUNSZ" );
test( "637572d0/36572698", "ZSNUTJRL" );
test( "baddb607/d66b6c05", "LTJZTSSSN" );
test( "db74cd75/6dac6b57", "ZZZTJZRJNU" );
test( "3606c2e8/1b0d8358", "ZZSSLTJ" );
test( "ad98c306/e6cc6183", "UZZZZZZ" );
test( "4a4aaee3/db6eeaa6", "JJLLUUNNS" );
test( "ecd9bbb6/598cd124", "TSSZZTTRR" );
test( "e0000002/40000003", "TL" );
test( "a0000007/e0000005", "UN" );
test( "c0000003/80000006", "RS" );
test( "40000006/c0000003", "JZ" );
test( "01da94db/00b3b6b2", "TSUJLRSR" );
test( "76eeaaea/24aaeeae", "TRNNUUNU" );
test( "1dacaeee/1566e444", "NRJZUTTT" );
test( "26c9ac60/6c6d66c0", "JSZLRJZS" );
test( "6c977620/36da5360", "ZZLLTNZJ" );
test( "069aeae6/0db34eac", "SJSLTUNS" );
test( "06d53724/049da56c", "RRULRNJJ" );
test( "069b58b0/04d66da0", "RLRSLZJR" );
test( "1b6eced4/11b46a9c", "RZZTZNRU" );
test( "522e8b80/db6ad900", "JLLJNLJT" );
test( "6546cdd0/376c6898", "ZULSZRTL" );
test( "4e6d5b70/6ad9d620", "LNSSURST" );
test( "37367772/65635256", "SNSZNTNJ" );
test( "25535d58/377669cc", "LUUSLTUZ" );
test( "0ae6a55d/0eacedcb", "UNSUJUTJ" );
test( "76762edc/23536a88", "TZNZJNRT" );
