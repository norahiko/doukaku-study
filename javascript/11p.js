"use strict";

function solve(input) {
    var nums    = input.split("").map(function(n) { return parseInt(n, 36) });
    var longest = 0;

    for(var diff = 1; diff <= 36; diff++) {
        for(var start = 0; start < nums.length; start++) {
            var len = 1;
            var prev = nums[start];
            for(var i = start; i < nums.length; i++) {
                if(nums[i] - prev === diff) {
                    prev = nums[i];
                    len++;
                }
            }
            if(longest < len) {
                longest = len;
            }
        }
    }
    return longest.toString();
}

function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test( "12345abcz"                           , "5" );
test( "012abku"                             , "4" );
test( "01245689cdeghik"                     , "6" );
test( "0"                                   , "1" );
test( "m"                                   , "1" );
test( "01"                                  , "2" );
test( "az"                                  , "2" );
test( "0az"                                 , "2" );
test( "0ak"                                 , "3" );
test( "05ak"                                , "3" );
test( "01349acdrsuv"                        , "2" );
test( "01245789efgipqstux"                  , "3" );
test( "0123456789abcdefghijklmnopqrstuvwxyz", "36" );
test( "02468acegikmoqsuwy"                  , "18" );
test( "0369cfilorux"                        , "12" );
test( "048cgkosw"                           , "9" );
test( "05afkpuz"                            , "8" );
test( "0123456789abcdefghjklmnopqrstuvwxyz" , "18" );
test( "0123456789bcdefghijklmopqrstuvwxyz"  , "12" );
test( "0156abfgklpquv"                      , "7" );
test( "0167cdijopuv"                        , "6" );
test( "0178eflmst"                          , "5" );
test( "0189ghopwx"                          , "5" );
test( "019aijrs"                            , "4" );
test( "012567abcfghklmpqruvw"               , "7" );
test( "012678cdeijkopquvw"                  , "6" );
test( "012789efglmnstu"                     , "5" );
test( "01289aghiopqwxy"                     , "5" );
test( "0129abijkrst"                        , "4" );
test( "01235678abcdfghiklmnpqrsuvwx"        , "7" );
test( "01236789cdefijklopqruvwx"            , "12" );
test( "0123789aefghlmnostuv"                , "5" );
test( "012389abghijopqrwxyz"                , "5" );
test( "01239abcijklrstu"                    , "4" );
test( "368acdknouvz"                        , "4" );
test( "369chikmnopqruwx"                    , "6" );
test( "05689cdefghijklmnopqrstvwy"          , "18" );
test( "2489abdeiklrsuvwz"                   , "4" );
test( "678bhijklnpqrsuvwxyz"                , "6" );
test( "1246cfjkopquxz"                      , "5" );
test( "123459abcefhilmotuvx"                , "6" );
test( "02578acdefikmopqsuvwxz"              , "8" );
test( "135abdefghijlopstuwz"                , "7" );
test( "0126789fgjnotuvxy"                   , "5" );
test( "2345678defjkmnoqrtvwxy"              , "7" );
test( "02568bdemnostw"                      , "5" );
test( "145689bdfhilnqrstvwxz"               , "6" );
test( "4aghjrtuvwxyz"                       , "7" );
test( "158achklmqstwy"                      , "3" );
test( "012346abceghjknortv"                 , "5" );
