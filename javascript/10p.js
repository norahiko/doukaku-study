var RANK_ORDER = "A2345678910JQK";

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

function collectRanks(cards) {
    return cards.map(function(c) { return c.rank }).join("");
}

function isStraight(cards) {
    var ranks = collectRanks(cards);
    return "A2345678910JQK".indexOf(ranks) !== -1 || ranks === "A10JQK" || ranks === "AJQK";
}

function isFlash(cards) {
    var suit = cards[0].suit;
    for(var i = 1; i < cards.length; i++) {
        if(suit !== cards[i].suit) return false;
    }
    return true;
}

function isRoyal(cards) {
    return "A10JQK" === collectRanks(cards);
}

function getHand(cards) {
    return (isStraight(cards) ? 1 : 0) + (isFlash(cards) ? 2 : 0);
}

function parseCards(input) {
    return input.match(/[0-9AJQK]+[shdc]/g).map(function(match) {
        return {
            rank: match.slice(0, -1),
            suit: match.slice(-1),
        };
    }).sort(function(a, b) {
        return RANK_ORDER.indexOf(a.rank) > RANK_ORDER.indexOf(b.rank);
    });
}

function solve(input) {
    var cards = parseCards(input);

    switch(getHand(cards)) {
        case 3: return isRoyal(cards) ? "RF" : "SF";
        case 2: return "FL";
        case 1: return "ST";
        case 0:
            var fourHands = combination(cards, 4).map(getHand);
            switch(Math.max.apply(Math, fourHands)) {
                case 3: return "4SF";
                case 2: return "4F";
                case 1: return "4S";
                case 0: return "-";
            }
    }
}

function test(input, expected) {
    var result = solve(input);
    if(result !== expected) {
        console.log("-------------\ninput = %s\n\nexpected = %s\nresult   = %s", input, expected, result);
    }
}

test( "Qs9s3dJd10h" , "4S" );
test( "KdAdJd10dQd" , "RF" );
test( "QhJhKhAh10h" , "RF" );
test( "10dAdJsQdKd" , "ST" );
test( "Kd10dAdJd3d" , "FL" );
test( "4d3d2dAd5d"  , "SF" );
test( "5d5d2d3dAd"  , "FL" );
test( "4d2sAd5d3d"  , "ST" );
test( "As10dJdQdKd" , "ST" );
test( "10d10dQdAsJd", "4F" );
test( "AcJd10dQdKd" , "ST" );
test( "Kd2sJdAdQd"  , "4SF" );
test( "JdAdQcKd2s"  , "4S" );
test( "KdAdKdJd2s"  , "4F" );
test( "As2dKdQdJd"  , "4F" );
test( "AsKdQd2dJh"  , "4S" );
test( "QhAd2s3dKd"  , "-" );
test( "Ad4dKh3s2d"  , "4S" );
test( "3d2dAh5d4s"  , "ST" );
test( "QcKdAs2dJd"  , "4S" );
test( "2dQcJdAs10d" , "-" );
test( "4d7d5s3c2d"  , "4S" );
test( "7d5s4dAd3c"  , "-" );
test( "3s8s10sQs6s" , "FL" );
test( "6hAh3h2h8h"  , "FL" );
test( "3h4hJh9hQh"  , "FL" );
test( "3s6s5s2sQs"  , "FL" );
test( "9d3cKdQc2c"  , "-" );
test( "5sKs7hQcKh"  , "-" );
test( "Ad6d7h7c9h"  , "-" );
test( "10h4cAh6s10c", "-" );
test( "9sKsJcQs10d" , "ST" );
test( "5d3c2cAs4c"  , "ST" );
test( "KcQs9c10sJs" , "ST" );
test( "9d8s10hJdQd" , "ST" );
test( "6c5s10h7d4c" , "4S" );
test( "QhJcKsAh8c"  , "4S" );
test( "JsQc3h10cKs" , "4S" );
test( "10c9h7hAd8d" , "4S" );
test( "3d4dKd8d5c"  , "4F" );
test( "10h3hQh9h2s" , "4F" );
test( "Qh5h7h9h6c"  , "4F" );
test( "6s8s7s3sKc"  , "4F" );
test( "10h8h9hJhQh" , "SF" );
test( "10h9hQhKhJh" , "SF" );
test( "6d4d7d5d3d"  , "SF" );
test( "6h9h7h5h8h"  , "SF" );
test( "Ac6s4s3s5s"  , "4SF" );
test( "3c9d2c5c4c"  , "4SF" );
test( "Kh2sQh10hJh" , "4SF" );
test( "4h5h2h3h4s"  , "4SF" );
test( "Js10sAsQsKs" , "RF" );
test( "10dKdQdAdJd" , "RF" );
