// 第一回 オフラインリアルタイムどう書くの問題
// Tick-Tack-Toe
// http://nabetani.sakura.ne.jp/hena/1/

"use strict";

var wonPattern = [ 448, 56, 7, 292, 146, 73, 273, 84 ];

function judge(moves, start, len) {
    var bits = 0;
    for(var i = start; i < len; i += 2) {
        bits |= Math.pow(2, moves[i] - 1);
    }
    return wonPattern.some(function(p) { return (p & bits) === p });
}

function tickTackToe(moves, count) {
    var x = count & 1;
    if(count === 9 || count === moves.length) {
        return "Draw game.";
    }
    if(moves.indexOf(moves[count]) < count) {
        return "Foul : " + (x ? "o" : "x") + " won.";
    }
    if(judge(moves, x, count + 1)) {
        return (x ? "x" : "o") + " won.";
    } else {
        return tickTackToe(moves, count + 1);
    }
}

function solve (input) {
    input = input.split("").map(Number);
    return tickTackToe(input, 0);
}

function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test("79538246"     , "x won.");
test("35497162193"  , "x won.");
test("61978543"     , "x won.");
test("254961323121" , "x won.");
test("6134278187"   , "x won.");
test("4319581"      , "Foul : x won.");
test("9625663381"   , "Foul : x won.");
test("7975663"      , "Foul : x won.");
test("2368799597"   , "Foul : x won.");
test("18652368566"  , "Foul : x won.");
test("38745796"     , "o won.");
test("371929"       , "o won.");
test("758698769"    , "o won.");
test("42683953"     , "o won.");
test("618843926"    , "Foul : o won.");
test("36535224"     , "Foul : o won.");
test("882973"       , "Foul : o won.");
test("653675681"    , "Foul : o won.");
test("9729934662"   , "Foul : o won.");
test("972651483927" , "Draw game.");
test("5439126787"   , "Draw game.");
test("142583697"    , "Draw game.");
test("42198637563"  , "Draw game.");
test("657391482"    , "Draw game.");
