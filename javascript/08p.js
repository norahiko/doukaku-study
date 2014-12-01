var codeTable = [
    [ "000"     , "t"   ],
    [ "0010"    , "s"   ],
    [ "0011"    , "n"   ],
    [ "0100"    , "i"   ],
    [ "01010"   , "d"   ],
    [ "0101101" , "c"   ],
    [ "010111"  , "l"   ],
    [ "0110"    , "o"   ],
    [ "0111"    , "a"   ],
    [ "10"      , "e"   ],
    [ "1100"    , "r"   ],
    [ "1101"    , "h"   ],
    [ "111"     , "!!!" ],
];

String.prototype.startsWith = function(prefix) {
    return prefix === this.slice(0, prefix.length);
};

function hexToBin(hexes) {
    return hexes.split("").map(function(hex) {
        return (parseInt(hex, 16).toString(2).split("").reverse().join("") + "000").slice(0, 4);
    }).join("");
}

function solve(input) {
    var bin    = hexToBin(input);
    var orig   = bin;
    var result = "";

    for(var i = 0; i < codeTable.length; i++) {
        var code  = codeTable[i];
        if(bin.startsWith(code[0])) {
            bin = bin.slice(code[0].length);
            if(code[1] === "!!!") {
                break;
            } else {
                result += code[1];
                i = -1;
            }
        }

        if(i === codeTable.length - 1) {
            return "*invalid*";
        }
    }
    return result + ":" + (orig.length - bin.length);
}

function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test( "16d9d4fbd"     , "ethanol:30" );
test( "df"            , "e:5" );
test( "ad7"           , "c:10" );
test( "870dcb"        , "t:6" );
test( "880f63d"       , "test:15" );
test( "a57cbe56"      , "cat:17" );
test( "36abef2"       , "roll:23" );
test( "ad576cd8"      , "chant:25" );
test( "3e2a3db4fb9"   , "rails:25" );
test( "51aa3b4c2"     , "eeeteee:18" );
test( "ad5f1a07affe"  , "charset:31" );
test( "4ab8a86d7afb0f", "slideshare:42" );
test( "ac4b0b9faef"   , "doctor:30" );
test( "cafebabe"      , "nlh:17" );
test( "43e7"          , "sra:15" );
test( "53e7"          , "eera:15" );
test( "86cf"          , "tera:16" );
test( "b6cf"          , "hon:15" );
test( "0"             , "*invalid*" );
test( "c"             , "*invalid*" );
test( "d"             , "*invalid*" );
test( "e"             , "*invalid*" );
test( "babecafe"      , "*invalid*" );
test( "8d"            , "*invalid*" );
test( "ad"            , "*invalid*" );
test( "af"            , "*invalid*" );
test( "ab6e0"         , "*invalid*" );
test( "a4371"         , "*invalid*" );
test( "a4371"         , "*invalid*" );
test( "96e3"          , "*invalid*" );
test( "0dc71"         , "*invalid*" );
test( "2a9f51"        , "*invalid*" );
test( "a43fb2"        , "*invalid*" );
test( "ab6e75"        , "*invalid*" );
test( "a5dcfa"        , "*invalid*" );
test( "ca97"          , "*invalid*" );
test( "6822dcb"       , "*invalid*" );
