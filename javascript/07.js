"use strict";

function repeat(c, num) {
    var res = "";
    for(var i = 0; i < num; i++) res += c;
    return res;
}

function solve(input) {
    var inputs  = input.split(":");
    var seatNum = parseInt(inputs[0]);
    var seat    = "*" + repeat("-", seatNum) + "*";

    inputs[1].split("").forEach(function(event) {
        if(event.toLowerCase() === event) {
            seat = seat.replace(event.toUpperCase(), "-");
        } else {
            seat = sit(seat, event);
        }
    });
    return seat.slice(1, -1);
}

function sit(seat, person) {
    var patterns = [
        /[-*]-[-*]/,
        /\*-./,
        /.-[-*]/,
        /[-*]-./,
        /.-./,
    ];
    for(var i = 0; i < patterns.length; i++) {
        if(seat.match(patterns[i])) {
            return seat.replace(patterns[i], function(match) {
                return match[0] + person + match[2];
            });
        }
    }
}

function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test("6:NABEbBZn"        , "-ZAB-E");
test("1:A"               , "A");
test("1:Aa"              , "-");
test("2:AB"              , "AB");
test("2:AaB"             , "B-");
test("2:AZa"             , "-Z");
test("2:AZz"             , "A-");
test("3:ABC"             , "ACB");
test("3:ABCa"            , "-CB");
test("4:ABCD"            , "ADBC");
test("4:ABCbBD"          , "ABDC");
test("4:ABCDabcA"        , "-D-A");
test("5:NEXUS"           , "NUESX");
test("5:ZYQMyqY"         , "ZM-Y-");
test("5:ABCDbdXYc"       , "AYX--");
test("6:FUTSAL"          , "FAULTS");
test("6:ABCDEbcBC"       , "AECB-D");
test("7:FMTOWNS"         , "FWMNTSO");
test("7:ABCDEFGabcdfXYZ" , "YE-X-GZ");
test("10:ABCDEFGHIJ"     , "AGBHCIDJEF");
