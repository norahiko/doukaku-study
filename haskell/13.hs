-- オフラインリアルタイムどう書く第13回の問題
-- 積み木の水槽
-- http://qiita.com/Nabetani/items/936e7885f4c607472060

-- ブロックのないマスの集合から、水が底か左右に流れるマスの集合を引いて答えを出しました。
-- その後、1段ずつ調べる簡単な解法を思いついたので、このコードは少し冗長かも。


import Data.Char
import Data.List
import qualified Data.Set as Set

type Pos = (Int, Int)

allBlocks :: [Int] -> [Pos]
allBlocks heights = concatMap blockLine $ zip heights [0..]

blockLine :: (Int, Int) -> [(Int, Int)]
blockLine (height, x) = zip (repeat x) [0..height-1]

solve :: String -> String
solve input = show . Set.size $ waters
    where
        heights          = map digitToInt input
        height           = maximum heights
        width            = length input
        allPos           = Set.fromList [(x, y) | x <- [0..width-1], y <- [0..height-1]]
        blocks           = Set.fromList $ allBlocks heights
        notBlocks        = Set.difference allPos blocks
        waters           = Set.difference notBlocks (Set.fromList flowables)

        bottomless       = [(x, 0) | x <- findIndices (== 0) heights]
        leftless         = (0, head heights)
        rightless        = (width-1, last heights)
        flowables        = concatMap flow (leftless : rightless : bottomless)

        valid pos@(x, _) = 0 <= x && x < width && not (pos `Set.member` blocks)
        flowSide d pos   = takeWhile valid $ iterate (\(x, y) -> (x+d, y)) pos
        flow (x, y)  = let line = [(x, y') | y' <- [y..height-1]]
                           in line ++ concatMap (flowSide 1) line ++ concatMap (flowSide (-1)) line

test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input


main :: IO ()
main = do
    test "83141310145169154671122"               "24"
    test "923111128"                             "45"
    test "923101128"                             "1"
    test "903111128"                             "9"
    test "3"                                     "0"
    test "31"                                    "0"
    test "412"                                   "1"
    test "3124"                                  "3"
    test "11111"                                 "0"
    test "222111"                                "0"
    test "335544"                                "0"
    test "1223455321"                            "0"
    test "000"                                   "0"
    test "000100020003121"                       "1"
    test "1213141516171819181716151413121"       "56"
    test "712131415161718191817161514131216"     "117"
    test "712131405161718191817161514031216"     "64"
    test "03205301204342100"                     "1"
    test "0912830485711120342"                   "18"
    test "1113241120998943327631001"             "20"
    test "7688167781598943035023813337019904732" "41"
    test "2032075902729233234129146823006063388" "79"
    test "8323636570846582397534533"             "44"
    test "2142555257761672319599209190604843"    "41"
    test "06424633785085474133925235"            "51"
    test "503144400846933212134"                 "21"
    test "1204706243676306476295999864"          "21"
    test "050527640248767717738306306596466224"  "29"
    test "5926294098216193922825"                "65"
    test "655589141599534035"                    "29"
    test "7411279689677738"                      "34"
    test "268131111165754619136819109839402"     "102"
