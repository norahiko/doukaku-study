"use strict";

var rankOrder = {
    3: 3, 4: 4, 5: 5, 6: 6, 7: 7, 8: 8, 9: 9, T: 10, J: 11, Q: 12, K: 13, A: 14, 2: 15, o: 16
};

function combination(ary, n) {
    if(n === 0) {
        return [[]];
    } else if(ary.length === 0) {
        return [];
    }
    return combination(ary.slice(1), n - 1).map(function(xs) {
        return [ary[0]].concat(xs.slice());
    }).concat(combination(ary.slice(1), n));
}

function commonRank(cards) {
    var rank = cards[0][1];
    for(var i = 1; i < cards.length; i++) {
        if(rank === "o") {
            rank = cards[i][1];
        } else if(cards[i][1] !== "o" && cards[i][1] !== rank) {
            return null;
        }
    }
    return rank;
}

function solve(input) {
    var splited   = input.split(",");
    var fieldRank = commonRank(splited[0].match(/../g));
    var fieldNum  = splited[0].length / 2;
    var handCards = splited[1].match(/../g) || [""];
    var results   = combination(handCards, fieldNum).filter(function(hand) {
        var handRank = commonRank(hand);
        return handRank && rankOrder[fieldRank] < rankOrder[handRank];
    });

    if(results.length === 0) {
        return "-";
    } else {
        return results.map(function(result) {
            return result.join("");
        }).join(",");
    }
}

// テストコードは省略
var inputs = [
    "DJ,",
    "H7,HK",
    "S3,D4D2",
    "S9,C8H4",
    "S6,S7STCK",
    "H4,SAS8CKH6S4",
    "ST,D6S8JoC7HQHAC2CK",
    "SA,HAD6S8S6D3C4H2C5D4CKHQS7D5",
    "S2,D8C9D6HQS7H4C6DTS5S6C7HAD4SQ",
    "Jo,HAC8DJSJDTH2",
    "S4Jo,CQS6C9DQH9S2D6S3",
    "CTDT,S9C2D9D3JoC6DASJS4",
    "H3D3,DQS2D6H9HAHTD7S6S7Jo",
    "D5Jo,CQDAH8C6C9DQH7S2SJCKH5",
    "C7H7,S7CTH8D5HACQS8JoD6SJS5H4",
    "SAHA,S7SKCTS3H9DJHJH7S5H2DKDQS4",
    "JoC8,H6D7C5S9CQH9STDTCAD9S5DAS2CT",
    "HTST,SJHJDJCJJoS3D2",
    "C7D7,S8D8JoCTDTD4CJ",
    "DJSJ,DTDKDQHQJoC2",
    "C3H3D3,CKH2DTD5H6S4CJS5C6H5S9CA",
    "D8H8S8,CQHJCJJoHQ",
    "H6D6S6,H8S8D8C8JoD2H2",
    "JoD4H4,D3H3S3C3CADASAD2",
    "DJHJSJ,SQDQJoHQCQC2CA",
    "H3D3Jo,D4SKH6CTS8SAS2CQH4HAC5DADKD9",
    "C3JoH3D3,S2S3H7HQCACTC2CKC6S7H5C7",
    "H5C5S5D5,C7S6D6C3H7HAH6H4C6HQC9",
    "H7S7C7D7,S5SAH5HAD5DAC5CA",
    "D4H4S4C4,S6SAH6HAD6DAC6CAJo",
    "DTCTSTHT,S3SQH3HQD3DQC3CQJo",
    "JoS8D8H8,S9DTH9CTD9STC9CAC2",
];

inputs.forEach(function(input) {
    console.log(solve(input));
});
