function solve(input) {
    var vec = [0, 1];
    var x = 1;
    var y = 0;
    var result = "";

    while(0 <= x && x < 3 && 0 <= y && y < 3) {
        var index = x + y * 3;
        var rail = input[index];
        result += "ABCDEFGHI"[index];

        if(rail === "1") {
            vec = [vec[1], vec[0]];
        } else if(rail === "2") {
            vec = [-vec[1], -vec[0]];
        }
        x += vec[0];
        y += vec[1];
    }
    return result;
}

function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test("101221102", "BEDGHIFEH");
test("000000000", "BEH");
test("111111111", "BCF");
test("222222222", "BAD");
test("000211112", "BEFIHEDGH");
test("221011102", "BADGHIFEBCF");
test("201100112", "BEHIFCBADEF");
test("000111222", "BEFIH");
test("012012012", "BC");
test("201120111", "BEDABCFI");
test("220111122", "BADEHGD");
test("221011022", "BADG");
test("111000112", "BCFIHEBA");
test("001211001", "BEFI");
test("111222012", "BCFEHIF");
test("220111211", "BADEHI");
test("211212212", "BCFEBAD");
test("002112210", "BEFC");
test("001010221", "BEF");
test("100211002", "BEFIHG");
test("201212121", "BEFCBAD");
