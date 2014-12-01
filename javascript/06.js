function parent(p) {
    return (p + 1) / 3 | 0;
}

function solve(input) {
    var a = parseInt(input.split("->")[0]);
    var b = parseInt(input.split("->")[1]);

    switch(true) {
        case a                 === b                 : return "me";
        case parent(a)         === b                 : return "mo";
        case a                 === parent(b)         : return "da";
        case parent(a)         === parent(b)         : return "si";
        case parent(parent(a)) === parent(b)         : return "au";
        case parent(a)         === parent(parent(b)) : return "ni";
        case parent(parent(a)) === parent(parent(b)) : return "co";
        default                                      : return "-";
    }
}

function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test( "5->2", "mo" );
test( "28->10", "au" );
test( "1->1", "me" );
test( "40->40", "me" );
test( "27->27", "me" );
test( "7->2", "mo" );
test( "40->13", "mo" );
test( "9->3", "mo" );
test( "4->1", "mo" );
test( "1->3", "da" );
test( "12->35", "da" );
test( "3->8", "da" );
test( "6->19", "da" );
test( "38->40", "si" );
test( "9->8", "si" );
test( "4->2", "si" );
test( "15->16", "si" );
test( "40->12", "au" );
test( "10->4", "au" );
test( "21->5", "au" );
test( "8->2", "au" );
test( "3->5", "ni" );
test( "11->39", "ni" );
test( "2->13", "ni" );
test( "13->32", "ni" );
test( "14->22", "co" );
test( "40->34", "co" );
test( "5->8", "co" );
test( "12->10", "co" );
test( "1->27", "-" );
test( "8->1", "-" );
test( "12->22", "-" );
test( "2->40", "-" );
test( "32->31", "-" );
test( "13->14", "-" );
