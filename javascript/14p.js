"use strict";

function isCross(a, b, x, y) {
    return (x < a && a < y && (b < x || y < b)) ||
           (x < b && b < y && (a < x || y < a));
}

function solve(input) {
    var lines = [];
    var count = 0;
    for(var a = 0; a < input.length - 1; a++) {
        for(var b = a + 1; b < input.length; b++) {
            if(input[a] === input[b]) {
                lines.push([a, b]);
            }
        }
    }
    for(a = 0; a < lines.length - 1; a++) {
        for(b = a + 1; b < lines.length; b++) {
            if(isCross(lines[a][0], lines[a][1], lines[b][0], lines[b][1])) {
                count += 1;
            }
        }
    }
    return count.toString();
}


function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test( "aabbca1bcb"    , "14" );
test( "111ZZZ"        , "0" );
test( "v"             , "0" );
test( "ww"            , "0" );
test( "xxx"           , "0" );
test( "yyyy"          , "1" );
test( "zzzzz"         , "5" );
test( "abcdef"        , "0" );
test( "abcaef"        , "0" );
test( "abbaee"        , "0" );
test( "abcacb"        , "2" );
test( "abcabc"        , "3" );
test( "abcdabcd"      , "6" );
test( "abcadeabcade"  , "23" );
test( "abcdeedcba"    , "0" );
test( "abcdeaedcba"   , "8" );
test( "abcdeaedcbad"  , "16" );
test( "QQQQXXXX"      , "2" );
test( "QwQQmQXmXXwX"  , "14" );
test( "111222333"     , "0" );
test( "aaAAaA"        , "4" );
test( "121232313"     , "12" );
test( "1ab1b"         , "1" );
test( "abcdefbadcfe"  , "12" );
test( "abxcdefbadcfex", "14" );
test( "dtnwtkt"       , "0" );
test( "mvubvpp"       , "0" );
test( "moggscd"       , "0" );
test( "kzkjzpkw"      , "2" );
test( "fbifybre"      , "1" );
test( "rrrfjryki"     , "1" );
test( "wrbbdwsdwtx"                                                               , "2" );
test( "vvucugvxbvgx"                                                              , "9" );
test( "ojkjzyasjwbfjj"                                                            , "5" );
test( "ggffyuxnkyypifff"                                                          , "5" );
test( "vcgtcqlwrepwvkkogl"                                                        , "4" );
test( "xeqtmmgppwcjpcisogxbs"                                                     , "4" );
test( "lukltpeucrqfvcupnpxwmoj"                                                   , "6" );
test( "zpzswlkkoqwwndwpfdpkhtzgtn"                                                , "31" );
test( "bkfeflagfvluelududqjcvfyvytfw"                                             , "45" );
test( "rvqbhfmcjjqlpqzulzerxgyowiwrfkmhw"                                         , "26" );
test( "qyxvpdtoeexbqsethwjwmqszcxxjnsdoeaet"                                      , "144" );
test( "rjmsgmswhcolmpbhmpncziymydyalrcnevsrespj"                                  , "133" );
test( "oxetnyjzjbysnwktfwzndlejfndsqeetsnjvsicyjehd"                              , "395" );
test( "wzvddnddzogywcqxbyvagbzmsmtcmrrlbnebmvhaemjouaqim"                         , "219" );
test( "karhphxcxqgsyorhusbumbqzocuzvnwzwcpxgsksrviihxrgsrhji"                     , "461" );
test( "oxgbononhqdxzmkysgijwvxljpaazmgkurkpffeuwywwuyxhyfkicgyzyc"                , "441" );
test( "sdgsrddwsrwqthhdvhrjhgtxwgurgyiygtktgtughtogzaqmcafkljgpniddsvb"           , "1077" );
test( "qemhecchkgzhxmdcsltwhpoyhkapckkkzosmklcvzkiiucrvzzznmhjfcdumuflavxik"      , "1711" );
test( "ffqmsirwpxrzfkbvmmfeptkbhnrvfcywthkwkbycmayhhkgvuyecbwwofwthlmzruphrcujwhr", "2440" );
