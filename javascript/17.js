"use strict";

var TR      = 0;
var TL      = 1;
var BR      = 2;
var BL      = 3;
var T       = 4;
var B       = 5;
var R       = 6;
var L       = 7;
var DIAMOND = 8;

function open(dir, c) {
    if(c === DIAMOND) return [DIAMOND, DIAMOND];

    switch(dir) {
        case "T":
            switch(c) {
                case TR : return [R];
                case TL : return [L];
                case BR : return [TR, BR];
                case BL : return [TL, BL];
                case T  : return [DIAMOND];
                case B  : return [T, B];
                case R  : return [R, R];
                case L  : return [L, L];
            }
        case "B":
            switch(c) {
                case TR : return [TR, BR];
                case TL : return [TL, BL];
                case BR : return [R];
                case BL : return [L];
                case T  : return [T, B];
                case B  : return [DIAMOND];
                case R  : return [R, R];
                case L  : return [L, L];
            }

        case "R":
            switch(c) {
                case TR : return [T];
                case TL : return [TR, TL];
                case BR : return [B];
                case BL : return [BR, BL];
                case T  : return [T, T];
                case B  : return [B, B];
                case R  : return [DIAMOND];
                case L  : return [R, L];
            }

        case "L":
            switch(c) {
                case TR : return [TR, TL];
                case TL : return [T];
                case BR : return [BR, BL];
                case BL : return [B];
                case T  : return [T, T];
                case B  : return [B, B];
                case R  : return [R, L];
                case L  : return [DIAMOND];
            }
    }
}

var inits = {
    tr: TR,
    tl: TL,
    br: BR,
    bl: BL,
};

function solve(input) {
    var folds = input.split("-")[0];
    var cuts  = [inits[input.split("-")[1]]];

    for(var i = folds.length; 0 < i;  i--) {
        cuts = [].concat.apply([], cuts.map(function(c) {
            return open(folds[i - 1], c);
        }));
    }
    return cuts.filter(function(c) { return c === DIAMOND }).length.toString();
}


function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test("RRTRB-bl"  , "6");
test("R-tr"      , "0");
test("L-br"      , "0");
test("T-tl"      , "0");
test("B-tl"      , "0");
test("BL-br"     , "0");
test("LB-tl"     , "0");
test("RL-tl"     , "0");
test("BL-tl"     , "0");
test("TL-bl"     , "0");
test("RT-tr"     , "1");
test("TRB-tl"    , "0");
test("TRL-bl"    , "0");
test("TRB-br"    , "2");
test("LLB-bl"    , "2");
test("RTL-tr"    , "1");
test("LBB-tr"    , "0");
test("TLL-tl"    , "2");
test("RLRR-tr"   , "0");
test("BBTL-tl"   , "4");
test("TBBT-tr"   , "0");
test("LLBR-tl"   , "0");
test("LBRT-tl"   , "2");
test("RLBL-bl"   , "4");
test("BRRL-br"   , "3");
test("TBBTL-tl"  , "8");
test("TLBBT-br"  , "0");
test("LRBLL-br"  , "7");
test("TRRTT-br"  , "6");
test("BBBLB-br"  , "0");
test("RTTTR-tl"  , "4");
test("BBLLL-br"  , "6");
test("RRLLTR-tr" , "16");
test("TTRBLB-br" , "8");
test("LRBRBR-bl" , "14");
test("RBBLRL-tl" , "8");
test("RTRLTB-tl" , "12");
test("LBLRTR-tl" , "14");
test("RRLTRL-tl" , "16");
test("TBLTRR-br" , "12");
test("TTTRLTT-bl", "30");
test("TBBRTBL-tr", "15");
test("TRTRTLL-tr", "28");
test("TLLRTRB-tr", "24");
test("RLLBRLB-tr", "15");
test("LTLRRBT-tr", "32");
test("RBBRBLT-br", "21");
test("LLRLRLR-tr", "0");
