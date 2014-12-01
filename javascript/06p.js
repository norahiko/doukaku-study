function pointsInShape(shape) {
    var points = {};
    pointsInRect(points, shape[0], shape[1]);
    pointsInRect(points, shape[0], shape[2]);
    return points;
}

function pointsInRect(points, a, b) {
    var ax = Math.min(a.x, b.x);
    var ay = Math.min(a.y, b.y);
    var bx = Math.max(a.x, b.x);
    var by = Math.max(a.y, b.y);
    for(var y = ay; y <= by; y++) {
        for(var x = ax; x <= bx; x++) {
            points[x.toString() + y.toString()] = true;
        }
    }
}

function parseShape(nums) {
    return nums.split("-").map(function(num) {
        return { x: parseInt(num[0]), y: parseInt(num[1]) };
    });
}

function solve(input) {
    var shapes = input.split(",").map(parseShape);
    var pointsA = pointsInShape(shapes[0]);
    var pointsB = pointsInShape(shapes[1]);

    var count = 0;
    for(var p in pointsA) {
        if(pointsB[p]) {
            count += 1;
        }
    }
    return count.toString();
}

function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test("23-94-28,89-06-51", "11");
test("11-84-58,02-73-69", "40");
test("18-41-86,77-04-32", "26");
test("81-88-23,64-58-14", "0");
test("31-29-07,41-87-69", "0");
test("83-13-40,18-10-94", "1");
test("77-80-92,21-72-38", "2");
test("57-70-91,55-19-08", "3");
test("18-22-75,66-80-91", "4");
test("51-93-78,54-49-06", "5");
test("58-70-96,17-43-76", "6");
test("58-07-12,58-82-93", "7");
test("41-29-07,35-95-88", "8");
test("88-26-60,42-29-07", "9");
test("18-40-85,34-40-91", "10");
test("36-60-96,53-96-89", "11");
test("51-39-02,44-98-69", "12");
test("48-06-20,76-04-42", "13");
test("85-29-18,26-50-93", "14");
test("27-50-91,43-29-07", "15");
test("57-06-20,48-60-91", "16");
test("52-98-89,21-76-67", "17");
test("67-12-40,45-80-92", "18");
test("47-03-10,26-30-82", "19");
test("74-28-06,21-86-37", "20");
test("65-01-20,73-39-05", "21");
test("17-72-86,36-50-94", "22");
test("51-29-07,77-15-41", "23");
test("33-98-39,82-16-02", "24");
test("75-05-10,37-81-96", "25");
test("72-58-06,48-80-96", "26");
test("81-67-16,21-91-59", "27");
test("13-96-57,24-96-79", "28");
test("57-04-32,51-18-06", "29");
test("88-03-52,28-41-86", "30");
test("78-04-61,13-86-49", "31");
test("58-12-20,27-50-85", "32");
test("61-19-05,71-68-15", "33");
test("63-29-16,18-31-83", "34");
test("16-50-91,32-98-79", "35");
test("82-17-03,38-40-81", "36");
test("72-48-04,11-98-39", "37");
test("77-05-10,28-50-62", "38");
test("38-50-91,11-86-57", "39");
test("87-05-10,13-97-69", "40");
test("11-86-49,22-98-89", "44");
test("11-97-69,12-86-67", "46");
test("11-95-69,71-49-05", "47");
test("28-31-92,13-98-79", "48");
