"use strict";

function solve(input) {
    var monsterData = "BDFHJL";
    var weaponData  = "acegika";
    var weapons     = input.match(/[a-z]/g) || [];
    var monsters    = input.match(/[A-Z]/g) || [];
    var monsterNum  = monsters.length;
    var w;

    // jshint boss: true
    while(w = weapons.pop()) {
        var widx      = weaponData.indexOf(w);
        var target    = monsterData[widx];
        var newWeapon = weaponData[widx + 1];
        if(monsters.indexOf(target) !== -1) {
            weapons.push(newWeapon);
            monsters = monsters.filter(function(m) { return m !== target });
        }
    }
    return String(monsterNum - monsters.length);
}



function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}


test( "gLDLBgBgHDaD"                          , "6" );
test( "DBcDLaLgDBH"                           , "6" );
test( "JJca"                                  , "0" );
test( "FJDLBH"                                , "0" );
test( "HJBLFDg"                               , "6" );
test( "HBaDLFJ"                               , "6" );
test( "DJaHLB"                                , "2" );
test( "gDLHJF"                                , "3" );
test( "cJFgLHD"                               , "5" );
test( "FFBJaJJ"                               , "1" );
test( "FJeJFBJ"                               , "2" );
test( "iJFFJJB"                               , "3" );
test( "JBJiLFJF"                              , "5" );
test( "JDiFLFBJJ"                             , "8" );
test( "BDFDFFDFFLLFFJFDBFDFFFFDDFaDBFFB"      , "28" );
test( "DDFBFcBDFFFFFFLBFDFFBFLFDFDJDFDF"      , "24" );
test( "FDLBFDDBFFFeFFFFFDFBLDDFDDFBFFJF"      , "16" );
test( "FDBFFLFDFFDBBDFFBJDLFgDFFFDFFDFF"      , "0" );
test( "FDiFLDFFFFBDDJDDBFBFDFFFBFFDFLFF"      , "31" );
test( "FDFDJBLBLBFFDDFFFDFFFFFDDFBkFDFF"      , "30" );
test( "HBkFFFFHBLH"                           , "3" );
test( "FBHHFFFHLaB"                           , "2" );
test( "LFHFBBcHFHF"                           , "0" );
test( "LFBHFFeFHBH"                           , "7" );
test( "LgFHHHBFBFF"                           , "3" );
test( "FFiFHBHLBFH"                           , "0" );
test( "BFHHFFHBeFLk"                          , "10" );
test( "FHFaBBHFHLFg"                          , "5" );
test( "FFgacaFg"                              , "0" );
test( "JHDaDcBJiiHccBHDBDH"                   , "9" );
test( "FHJJLckFckFJHDFF"                      , "12" );
test( "DeDHJHDFHJBLHDLLDHJLBDD"               , "22" );
test( "gJLLLJgJgJLJL"                         , "0" );
test( "DaaaDDD"                               , "0" );
test( "HFeJFHiBiiBJeJBBFFB"                   , "9" );
test( "FJFFJDBHBHaLJBHJHDLHkLLLFFFgJgHJLHkJkB", "32" );
test( "giFLBiBJLLJgHBFJigJJJBLHFLDLL"         , "23" );
test( "cgkLJcLJJJJgJc"                        , "2" );
test( "LDFHJHcFBDBLJBLFLcFJcDFBL"             , "22" );
test( "JJHHHkHJkHLJk"                         , "1" );
test( "kHHBBaBgHagHgaHBBB"                    , "11" );
test( "HDBFFDHHHDFLDcHHLFDcJD"                , "20" );
test( "HFFFHeFFee"                            , "7" );
test( "gLLDHgDLgFL"                           , "1" );
test( "JJJBBaBBHBBHaLBHJ"                     , "7" );
test( "FBFBgJBDBDgF"                          , "0" );
test( "LLLLakakLakLL"                         , "7" );
test( "HeJHeJe"                               , "0" );
test( "LDFLBLLeBLDBBFFBLFBB"                  , "4" );
