function perm69(ary, n) {
    if(n === 0)  {
        return [[]];
    }
    var result = [];

    for(var i = 0; i < ary.length; i++) {
        perm69(ary.slice(0, i).concat(ary.slice(i+1)), n - 1).forEach(function(ps) {
            if(ary[i] === "6" || ary[i] === "9") {
                result.push(["6"].concat(ps));
                result.push(["9"].concat(ps));
            } else {
                result.push([ary[i]].concat(ps));
            }
        });
    }
    return result;
}


function solve(input) {
    var order     = parseInt(input.split(":")[0]);
    var cards     = input.split(":")[1].split("").sort();

    var cardsPerm = perm69(cards, 4)
        .map(function(cs) { return cs.join("") })
        .filter(function(cs) { return cs[0] !== "0" })
        .sort()
        .reduce(function(unique, num) {
            if(unique[unique.length - 1] !== num) {
                unique.push(num);
            }
            return unique;
        }, []);
    return cardsPerm[order - 1] || "-";
}


function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}


test( "13:01167" , "1109" );
test( "1:1234"   , "1234" );
test( "2:1234"   , "1243" );
test( "7:1234"   , "2134" );
test( "24:1234"  , "4321" );
test( "25:1234"  , "-" );
test( "2:1116"   , "1119" );
test( "2:0116"   , "1019" );
test( "3:6666"   , "6696" );
test( "16:6666"  , "9999" );
test( "10:01267" , "1097" );
test( "14:111167", "1671" );
test( "1:1111"   , "1111" );
test( "2:1111"   , "-" );
test( "1:666633" , "3366" );
test( "72:666611", "9999" );
test( "73:666622", "-" );
test( "1:666600" , "6006" );
test( "52:666600", "9999" );
test( "53:666600", "-" );
test( "25:06688" , "8086" );
test( "93:02566" , "6502" );
test( "11:06688" , "6809" );
test( "169:01268", "9801" );
test( "174:01268", "9821" );
test( "66:012288", "8201" );
