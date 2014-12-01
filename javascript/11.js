"use strict";

function hexToBin(hex) {
    return hex.split("").map(function(h) {
        return ("000" + parseInt(h, 16).toString(2)).slice(-4);
    }).join("");
}

function solve(input) {
    var lines = [0, 1, 2, 3, 4, 5, 6, 7, 8];
    input.split("-").map(hexToBin).forEach(function(bin) {
        var regex = /1+/g;
        var match;
        // jshint boss: true
        while(match = regex.exec(bin)) {
            var a = match.index;
            var b = match.index + match[0].length;
            var temp = lines[a];
            lines[a] = lines[b];
            lines[b] = temp;
        }
    });
    return lines.join("");
}

function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test( "d6-7b-e1-9e", "740631825" );
test( "83-4c-20-10", "123805476" );
test( "fb-f7-7e-df", "274056813" );
test( "55-33-0f-ff", "123456780" );
test( "00-00-00-00", "012345678" );
test( "00-00-00-55", "021436587" );
test( "40-10-04-01", "021436587" );
test( "00-00-aa-00", "103254768" );
test( "80-20-08-02", "103254768" );
test( "ff-7e-3c-18", "876543210" );
test( "aa-55-aa-55", "351708264" );
test( "55-aa-aa-55", "012345678" );
test( "db-24-db-e7", "812543670" );
test( "00-01-00-40", "021345687" );
test( "00-00-80-00", "102345678" );
test( "01-40-00-00", "021345687" );
test( "00-00-00-02", "012345768" );
test( "00-00-02-00", "012345768" );
test( "00-14-00-00", "012436578" );
test( "00-00-01-40", "021345687" );
test( "00-80-01-00", "102345687" );
test( "c8-00-00-81", "120354687" );
test( "05-48-08-14", "021435687" );
test( "24-05-00-f0", "413205687" );
test( "40-08-14-01", "021536487" );
test( "18-c8-80-80", "210534678" );
test( "1c-88-52-00", "120564738" );
test( "ec-dc-67-62", "213468705" );
test( "0a-b6-60-e9", "035162784" );
test( "52-d6-c6-c2", "120345678" );
test( "47-e7-b0-36", "231047658" );
test( "0f-85-91-aa", "108263754" );
test( "76-b6-ed-f3", "601435782" );
test( "f5-5e-f7-3d", "025847163" );
test( "dd-e7-fb-f9", "610247538" );
test( "8f-f4-af-fd", "583246017" );
test( "bf-fb-cb-f7", "105382674" );
test( "e5-fd-ff-ff", "512046378" );
test( "ef-df-ef-fe", "713205648" );
test( "bf-7f-fd-d7", "826437105" );
test( "36-ff-df-de", "814527603" );
test( "6f-dd-ff-ff", "230685147" );
