function transpose(mat) {
    var clone = [];
    mat.forEach(function(row) {
        clone.push(row.slice());
    });

    mat.length = clone[0].length;
    for(var y = 0; y < clone.length; y++) {
        for(var x = 0; x < clone[0].length; x++) {
            mat[x][y] = clone[y][x];
        }
    }
}

function solve(input) {
    var mat = [
        "414213".split(""),
        "732050".split(""),
        "236067".split(""),
        "645751".split(""),
        "316624".split(""),
        "605551".split(""),
    ];

    input.split("").forEach(function(s) {
        var i = "ABCDEFuvwxyz".indexOf(s);
        if(i < 6) {
            transpose(mat);
            mat.sort(function(a, b) { return a[i] - b[i] });
            transpose(mat);
        } else {
            mat.sort(function(a, b) { return a[i - 6] - b[i - 6] });
        }
    });

    return mat[0].join("");
}

function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test( "AvEx"     , "305027");
test( "A"        , "112344");
test( "C"        , "241413");
test( "F"        , "134214");
test( "u"        , "236067");
test( "w"        , "732050");
test( "y"        , "414213");
test( "yx"       , "732050");
test( "ux"       , "236067");
test( "EF"       , "131424");
test( "DF"       , "134124");
test( "Au"       , "055165");
test( "uA"       , "023667");
test( "By"       , "234114");
test( "yB"       , "114342");
test( "yBy"      , "357020");
test( "yByB"     , "350072");
test( "AuBvCw"   , "131244");
test( "FAuFBvFCw", "300527");
test( "AuBv"     , "112344");
test( "CwDx"     , "515056");
test( "FzyE"     , "324114");
test( "uAwDyB"   , "114324");
test( "zExCvF"   , "073520");
test( "uFxEv"    , "002357");
test( "DyCwB"    , "076362");
