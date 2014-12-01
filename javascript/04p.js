// オフラインリアルタイムどう書く第4回の参考問題
// フカシギの通行止め
// http://qiita.com/Nabetani/items/9c514267214d3917edf2

"use strict";

var width = 5;
var height = 5;
var goalX = width - 1;
var goalY = height - 1;

function makeBlocked(input) {
    var blocked = {};
    input.split(" ").forEach(function(vstr) {
        var vertexes = vstr.split("").map(function(ch) {
            var code = ch.charCodeAt(0) - "a".charCodeAt(0);
            return "" + (code / width | 0) + (code % width);
        });
        blocked[vertexes[0] + vertexes[1]] = true;
        blocked[vertexes[1] + vertexes[0]] = true;
    });
    return blocked;
}

function hasBlocked(blocked, vertex, next) {
    return blocked["" + vertex[0] + vertex[1] + next[0] + next[1]];
}

function walk(blocked, visited, vertex) {
    var key = "" + vertex[0] + vertex[1];

    if(vertex[0] === goalX && vertex[1] === goalY) {
        return 1;
    } else if(visited[key]) {
        return 0;
    }
    visited[key] = true;

    var sum = 0;
    [[1, 0], [-1, 0], [0, 1], [0, -1]].forEach(function(diff) {
        var n = [vertex[0] + diff[0], vertex[1] + diff[1]];
        if(!hasBlocked(blocked, vertex, n) && 0 <= n[0] && n[0] < width && 0 <= n[1] && n[1] < height) {
            sum += walk(blocked, visited, n);
        }
    });
    visited[key] = false;
    return sum;
}

function solve(input) {
    var blocked = makeBlocked(input);
    return walk(blocked, {}, [0, 0]).toString();
}

function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test(""                                , "8512");
test("af"                              , "4256");
test("xy"                              , "4256");
test("pq qr rs st di in ns sx"         , "184");
test("af pq qr rs st di in ns sx"      , "92");
test("bg ch di ij no st"               , "185");
test("bc af ch di no kp mr ns ot pu rs", "16");
test("ab af"                           , "0");
test("ty xy"                           , "0");
test("bg ch ej gh lm lq mr ot rs sx"   , "11");
test("ty ch hi mn kp mr rs sx"         , "18");
test("xy ch hi mn kp mr rs sx"         , "32");
test("ch hi mn kp mr rs sx"            , "50");
test("ab cd uv wx"                     , "621");
test("gh mn st lq qr"                  , "685");
test("fg gl lm mr rs"                  , "171");
