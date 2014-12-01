// オフラインリアルタイムどう書く第3回の問題
// Y字路巡り
// http://nabetani.sakura.ne.jp/hena/ord3ynode/

"use strict";

var graph = {
  "A": "BCD",
  "B": "CAE",
  "C": "ABF",
  "D": "EAF",
  "E": "FBD",
  "F": "CED",
};

function walk(input, from, to) {
    if(input.length === 0) {
        return to;
    }
    var nextNodes = graph[to];
    var fromIndex = nextNodes.indexOf(from);
    var direction = "brl".indexOf(input[0]);
    var next = nextNodes[(fromIndex + direction) % 3];
    return to + walk(input.slice(1), to, next);
}

function solve(input) {
    return walk(input, "B", "A");
}

function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test("b"              , "AB");
test("l"              , "AD");
test("r"              , "AC");
test("bbb"            , "ABAB");
test("rrr"            , "ACBA");
test("blll"           , "ABCAB");
test("llll"           , "ADEBA");
test("rbrl"           , "ACADE");
test("brrrr"          , "ABEDAB");
test("llrrr"          , "ADEFDE");
test("lrlll"          , "ADFEDF");
test("lrrrr"          , "ADFCAD");
test("rllll"          , "ACFDAC");
test("blrrrr"         , "ABCFEBC");
test("brllll"         , "ABEFCBE");
test("bbrllrrr"       , "ABACFDEFD");
test("rrrrblll"       , "ACBACABCA");
test("llrlrrbrb"      , "ADEFCADABA");
test("rrrbrllrr"      , "ACBABEFCAD");
test("llrllblrll"     , "ADEFCBCADEB");
test("lrrlllrbrl"     , "ADFCBEFDFCB");
test("lllrbrrlbrl"    , "ADEBCBACFCAB");
test("rrrrrrlrbrl"    , "ACBACBADFDEB");
test("lbrbbrbrbbrr"   , "ADABABEBCBCFE");
test("rrrrlbrblllr"   , "ACBACFCACFDAB");
test("lbbrblrlrlbll"  , "ADADFDABCFDFED");
test("rrbbrlrlrblrl"  , "ACBCBADFEBEFDA");
test("blrllblbrrrrll" , "ABCFDADEDABEDFE");
test("blrllrlbllrrbr" , "ABCFDABCBEFDEDA");
test("lbrbbrllllrblrr", "ADABABEFCBEDEBCF");
test("rrrrbllrlrbrbrr", "ACBACABCFDEDADFC");
