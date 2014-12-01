"use strict";

function flip(folds) {
    return folds.split("").reverse().map(function(f) {
        return f === "m" ? "V" : "m";
    }).join("");
}

function solve(input) {
    return input.split("").reverse().reduce(function(folds, dir) {
        var flipped = flip(folds);
        switch(dir) {
            case "L": return flipped + "V" + folds;
            case "J": return folds   + "V" + flipped;
            case "Z": return folds   + "m" + flipped  + "V" + folds;
            case "U": return flipped + "V" + folds    + "V" + flipped;
            case "S": return folds   + "V" + flipped  + "m" + folds;
        }
    }, "");
}


function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test( "JZ"    , "mVVmV" );
test( "J"     , "V" );
test( "L"     , "V" );
test( "Z"     , "mV" );
test( "U"     , "VV" );
test( "S"     , "Vm" );
test( "JL"    , "VVm" );
test( "JS"    , "VmVVm" );
test( "JU"    , "VVVmm" );
test( "LU"    , "mmVVV" );
test( "SL"    , "VVmmV" );
test( "SS"    , "VmVVmmVm" );
test( "SU"    , "VVVmmmVV" );
test( "SZ"    , "mVVmVmmV" );
test( "UL"    , "mVVVm" );
test( "UU"    , "mmVVVVmm" );
test( "UZ"    , "mVVmVVmV" );
test( "ZJ"    , "VmmVV" );
test( "ZS"    , "VmmVmVVm" );
test( "ZZ"    , "mVmmVVmV" );
test( "JJJ"   , "VVmVVmm" );
test( "JJZ"   , "mVVmVVmVmmV" );
test( "JSJ"   , "VVmmVVmVVmm" );
test( "JSS"   , "VmVVmmVmVVmVVmmVm" );
test( "JUS"   , "VmVVmVVmVVmmVmmVm" );
test( "JUU"   , "mmVVVVmmVVVmmmmVV" );
test( "JUZ"   , "mVVmVVmVVmVmmVmmV" );
test( "LJJ"   , "VmmVVVm" );
test( "LLS"   , "VmmVmVVmVVm" );
test( "LLU"   , "mmmVVVmmVVV" );
test( "LLZ"   , "mVmmVVmVVmV" );
test( "LSU"   , "mmVVVmmmVVVVmmmVV" );
test( "LSZ"   , "mVVmVmmVVmVVmVmmV" );
test( "LZL"   , "mmVVmVVmmVV" );
test( "LZS"   , "VmmVmVVmVVmmVmVVm" );
test( "LZU"   , "mmmVVVmmVVVmmmVVV" );
test( "SJL"   , "VVmVVmmmVVm" );
test( "SLU"   , "mmVVVVmmmVVmmmVVV" );
test( "SLZ"   , "mVVmVVmVmmVmmVVmV" );
test( "SSU"   , "VVVmmmVVVmmVVVmmmmVVVmmmVV" );
test( "SUJ"   , "mVVVmVVmmmVmmVVVm" );
test( "SUS"   , "VmVVmVVmVVmmVmmVmmVmVVmVVm" );
test( "SZZ"   , "mVmmVVmVVmVmmVVmVmmVmmVVmV" );
test( "UJJ"   , "VmmVVVmVVmm" );
test( "ULU"   , "mmmVVVmmVVVVmmmVV" );
test( "ULZ"   , "mVmmVVmVVmVVmVmmV" );
test( "UUU"   , "VVmmmmVVVmmVVVVmmVVVmmmmVV" );
test( "ZJU"   , "VVVmmmVVmmmVVVVmm" );
test( "ZLS"   , "VmVVmmVmmVmVVmVVm" );
test( "ZSJ"   , "VVmmVmmVVmmVVVmmV" );
test( "ZUJ"   , "mVVVmmVmmmVVmVVVm" );
test( "JJLJ"  , "mVVVmmVVmVVmmmV" );
test( "JLJJ"  , "VmmVVVmVVmmmVVm" );
test( "JLJL"  , "VmmVVVmVVmmmVVm" );
test( "LJJL"  , "VVmmVmmVVVmVVmm" );
test( "LLJJ"  , "VmmmVVmVVmmVVVm" );
test( "SZUS"  , "VmVVmVVmmVmmVmmVmVVmVVmVVmVVmmVmmVmmVmVVmVVmVVmmVmmVmmVmVVmVVmmVmmVmmVmVVmVVmVVm" );
test( "ULLS"  , "VmmVmmVmVVmVVmmVmVVmVVmVVmmVmmVmVVm" );
test( "JJJJZJ", "VmmVVVmmVVmVVmmVVmmmVVmVVmmVVVmmVVmmVmmVVmmmVVmVVmmVVVmmVVmVVmmVVmmmVVmmVmmVVVmmVVmmVmmVVmmmVVm" );
test( "JULLLJ", "mmVmmVVmmmVVmVVVmmVmmVVVmmVVmVVVmmVmmVVmmmVVmVVVmmVmmVVVmmVVmVVmmmVmmVVmmmVVmVVmmmVmmVVVmmVVmVV" );
test( "LJJJUL", "mVVVmVVmmmVVmVVVmmVmmmVmmVVVmVVmmmVmmVVVmmVmmmVVmVVVmVVmmmVVmVVVmmVmmmVVmVVVmVVmmmVmmVVVmmVmmmV" );
test( "LJSJJL", "VVmVVmmVVVmmVmmmVVmVVmmmVVmmVmmVVVmVVmmmVVmmVmmVVVmVVmmVVVmmVmmmVVmVVmmVVVmmVmmVVVmVVmmmVVmmVmm" );
test( "LZLLLJ", "mmVmmVVmmmVVmVVmmmVmmVVVmmVVmVVVmmVmmVVmmmVVmVVVmmVmmVVVmmVVmVVmmmVmmVVmmmVVmVVVmmVmmVVVmmVVmVV" );
test( "SJJJJL", "VVmVVmmVVVmmVmmVVVmVVmmmVVmmVmmVVVmVVmmVVVmmVmmmVVmVVmmmVVmmVmmmVVmVVmmVVVmmVmmVVVmVVmmmVVmmVmm" );
test( "ZLJLJL", "VmmVVVmmVmmmVVmVVmmVVVmVVmmmVVmmVmmVVVmmVmmmVVmmVmmVVVmVVmmmVVmVVmmVVVmmVmmmVVmVVmmVVVmVVmmmVVm" );
