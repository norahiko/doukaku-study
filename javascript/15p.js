"use strict";

function palindrome(str) {
    if(str.length < 2) return str.length;
    var len = [1];
    for(var i = 0; i < str.length; i++) {
        var r = str.lastIndexOf(str[i]);
        if(r !== i) {
            len.push(palindrome(str.slice(i + 1, r)) + 2);
        }
    }
    return Math.max.apply(Math, len);
}

function solve(input) {
    return palindrome(input).toString();
}

function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test( "I_believe_you_can_solve"       , "9" );
test( "a"                             , "1" );
test( "aa"                            , "2" );
test( "aaa"                           , "3" );
test( "ab"                            , "1" );
test( "aabb"                          , "2" );
test( "ABBA"                          , "4" );
test( "Abba"                          , "2" );
test( "1234567890"                    , "1" );
test( "1234567890987654321"           , "19" );
test( "abcdcba"                       , "7" );
test( "0a1b2c3d4c5b6a7"               , "7" );
test( "abcdcba0123210"                , "7" );
test( "abcdcba_123210"                , "7" );
test( "_bcdcba0123210"                , "7" );
test( "abcddcba0123210"               , "8" );
test( "abcdcba01233210"               , "8" );
test( "a0bc1dc2ba3210a"               , "9" );
test( "a0bc1ddc2ba3210"               , "8" );
test( "3a0bc1ddc2ba3210"              , "10" );
test( "11oooo1111o1oo1o111ooooooooooo", "20" );
test( "11o1111o1111oo11ooo11111ooo1oo", "20" );
test( "111111oo11o111ooo1o1ooo11ooo1o", "21" );
test( "11o1o1o11oo11o11oo111o1o1o11oo", "27" );
test( "oo111o1o11o1oo1ooo11o1o11o1o1o", "27" );
test( "1o1oo11111o1o1oo1o1o1111oo1o1o", "28" );
test( "QQooooQooooQQyQoyQQQyyyyQQoyoy", "15" );
test( "oQoooQooooQyoyQoyoyyyQQyQQQQoQ", "16" );
test( "yyyyyooyQyyyoyyQyyooyQoQoQQoQy", "17" );
test( "yyQoyQoyyQyQQoyooooyyQQyQyooQy", "24" );
test( "oQQooQoQyQQoyoQQoQyQyQyQoQoooo", "24" );
test( "oQQyQQyyQyQQoooyQQyyyQQQyyQQoy", "25" );
test( "WAk9iHI4jVDlStyudwTNqE138kwan2", "3" );
test( "c43fIu1Mlz0K9hEVOgGcUdbeB5ksa7", "3" );
test( "CAbYcW5VqHjzFdIkH_61PM0TsyRuie", "3" );
test( "jInQnUvSayrJTsQWujovbbqW0STvoj", "10" );
test( "iZDrvpUKgtj3FrZsZ4CLjrEgUdZzQG", "11" );
test( "ROgYUOu6er_DA7nB6UGquO1GUHC62R", "11" );
test( "Oh_be_a_fine_girl_kiss_me"     , "9" );
test( "8086_6502_6809_Z80"            , "11" );
test( "xcode_visualstudio_eclipse"    , "11" );
test( "word_excel_powerpoint_outlook" , "9" );
test( "abcdefghijklmnopqrstuvwxyz0123", "1" );
