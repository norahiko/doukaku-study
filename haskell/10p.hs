-- オフラインリアルタイムどう書く第10回の参考問題
-- ポーカーの残り＋
-- http://qiita.com/Nabetani/items/d819d1e5f2378317511e

-- 5枚で作れる最大の役が答えです。
-- 5枚で作れる役がなければ、カードから4枚の組み合わせて作れる最大の役を調べます。

import Data.List
import Data.List.Split
import Text.Regex

data Card = Card { rank :: Int , suit :: Char } deriving (Show)

data Hand = None | ST | FL | SF deriving (Show, Eq, Ord)

combination :: [a] -> Int -> [[a]]
combination _ 0      = [[]]
combination [] _     = []
combination (x:xs) n = map (x:) (combination xs (n-1)) ++ combination xs n

isFlash :: [Card] -> Bool
isFlash cs = all (== suit (head cs)) $ map suit cs

isStraight :: [Card] -> Bool
isStraight cards = let ranks = sort $ map rank cards
                   in isInfixOf ranks [1..13] || isRoyal cards || ranks == [1, 11, 12, 13]

isRoyal :: [Card] -> Bool
isRoyal cards = sort (map rank cards) == [1, 10, 11, 12, 13]

getHand :: [Card] -> Hand
getHand cards = [None, ST, FL, SF] !! (flash + straight)
    where
        flash    = if isFlash cards then 2 else 0
        straight = if isStraight cards then 1 else 0

solveHand :: [Card] -> String
solveHand cards = case getHand cards of
    SF   -> if isRoyal cards then "RF" else "SF"
    FL   -> "FL"
    ST   -> "ST"
    None -> case maximum [getHand cs | cs <- combination cards 4] of
        SF   -> "4SF"
        FL   -> "4F"
        ST   -> "4S"
        None -> "-"

parse :: String -> [Card]
parse input = do
    let input' = subRegex (mkRegex "10") input "T"
    [r, s] <- chunksOf 2 input'
    let (Just r') = elemIndex r "-A23456789TJQK"
    return $ Card r' s

solve :: String -> String
solve = solveHand . parse

test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "Qs9s3dJd10h"  "4S"
    test "KdAdJd10dQd"  "RF"
    test "QhJhKhAh10h"  "RF"
    test "10dAdJsQdKd"  "ST"
    test "Kd10dAdJd3d"  "FL"
    test "4d3d2dAd5d"   "SF"
    test "5d5d2d3dAd"   "FL"
    test "4d2sAd5d3d"   "ST"
    test "As10dJdQdKd"  "ST"
    test "10d10dQdAsJd" "4F"
    test "AcJd10dQdKd"  "ST"
    test "Kd2sJdAdQd"   "4SF"
    test "JdAdQcKd2s"   "4S"
    test "KdAdKdJd2s"   "4F"
    test "As2dKdQdJd"   "4F"
    test "AsKdQd2dJh"   "4S"
    test "QhAd2s3dKd"   "-" 
    test "Ad4dKh3s2d"   "4S"
    test "3d2dAh5d4s"   "ST"
    test "QcKdAs2dJd"   "4S"
    test "2dQcJdAs10d"  "-" 
    test "4d7d5s3c2d"   "4S"
    test "7d5s4dAd3c"   "-" 
    test "3s8s10sQs6s"  "FL"
    test "6hAh3h2h8h"   "FL"
    test "3h4hJh9hQh"   "FL"
    test "3s6s5s2sQs"   "FL"
    test "9d3cKdQc2c"   "-" 
    test "5sKs7hQcKh"   "-" 
    test "Ad6d7h7c9h"   "-" 
    test "10h4cAh6s10c" "-" 
    test "9sKsJcQs10d"  "ST"
    test "5d3c2cAs4c"   "ST"
    test "KcQs9c10sJs"  "ST"
    test "9d8s10hJdQd"  "ST"
    test "6c5s10h7d4c"  "4S"
    test "QhJcKsAh8c"   "4S"
    test "JsQc3h10cKs"  "4S"
    test "10c9h7hAd8d"  "4S"
    test "3d4dKd8d5c"   "4F"
    test "10h3hQh9h2s"  "4F"
    test "Qh5h7h9h6c"   "4F"
    test "6s8s7s3sKc"   "4F"
    test "10h8h9hJhQh"  "SF"
    test "10h9hQhKhJh"  "SF"
    test "6d4d7d5d3d"   "SF"
    test "6h9h7h5h8h"   "SF"
    test "Ac6s4s3s5s"   "4SF"
    test "3c9d2c5c4c"   "4SF"
    test "Kh2sQh10hJh"  "4SF"
    test "4h5h2h3h4s"   "4SF"
    test "Js10sAsQsKs"  "RF"
    test "10dKdQdAdJd"  "RF"
