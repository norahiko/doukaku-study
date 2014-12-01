function hexToMap(hex) {
    return hex.split("").map(function(h) {
        return ("000" + parseInt(h, 16).toString(2)).slice(-4);
    }).join("").match(/.{6}/g);
}

function solve(input) {
    var walls = hexToMap(input.split("/")[0]);
    var bombs = hexToMap(input.split("/")[1]);
    var fires = new Array(31).join("0").split("");
    var i;

    for(var y = 0; y < 5; y++) {
        for(var x = 0; x < 6; x++) {
            if(bombs[y][x] !== "1") continue;

            for(i = x; i < 6 && walls[y][i] === "0"; i++) {
                fires[y * 6 + i] = "1";
            }
            for(i = x; 0 <= i && walls[y][i] === "0"; i--) {
                fires[y * 6 + i] = "1";
            }
            for(i = y; i < 5 && walls[i][x] === "0"; i++) {
                fires[i * 6 + x] = "1";
            }
            for(i = y; 0 <= i && walls[i][x] === "0"; i--) {
                fires[i * 6 + x] = "1";
            }
        }
    }

    return (fires.join("") + "00").match(/.{4}/g).map(function(bin) {
        return parseInt(bin, 2).toString(16);
    }).join("");
}

function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test( "802b1200/01400c20", "53c40cfc" );
test( "28301068/84080504", "d64fef94" );
test( "100a4010/80010004", "e241850c" );
test( "81020400/000000fc", "0e3cfbfc" );
test( "80225020/7e082080", "7fdd24d0" );
test( "01201200/40102008", "fe1861fc" );
test( "00201000/01000200", "43c48f08" );
test( "00891220/81020408", "ff060c1c" );
test( "410033c0/0c300000", "3cf0c000" );
test( "00000000/01400a00", "7bf7bf78" );
test( "00000000/20000a00", "fca2bf28" );
test( "00000000/00000000", "00000000" );
test( "00cafe00/00000000", "00000000" );
test( "aaabaaaa/50000000", "51441040" );
test( "a95a95a8/56a56a54", "56a56a54" );
test( "104fc820/80201010", "ea30345c" );
test( "4a940214/05000008", "05000008" );
test( "00908000/05000200", "ff043f48" );
test( "00c48c00/fe1861fc", "ff3873fc" );
test( "00000004/81020400", "fffffff0" );
test( "111028b0/40021100", "e08fd744" );
test( "6808490c/01959000", "17f7b650" );
test( "30821004/81014040", "c75de5f8" );
test( "0004c810/10003100", "fe4937c4" );
test( "12022020/88200000", "edf08208" );
test( "2aa92098/01160000", "45165964" );
test( "00242940/10010004", "fc43c43c" );
test( "483c2120/11004c00", "33c3de10" );
test( "10140140/44004a04", "eda3fe3c" );
test( "0c901d38/72602200", "f36da280" );
