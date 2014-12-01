-- 第19回オフラインリアルタイムどう書くの参考問題
-- 三和数
-- http://qiita.com/Nabetani/items/0a711729fdea28b1c30b

import Data.List
import Data.List.Split
import qualified Data.Set as Set

solve :: String -> String
solve = output . search . parse

parse :: String -> [Int]
parse xs = map read $ splitOn "," xs

search :: [Int] -> [[Int]]
search input = filter isSubset triples'
    where
        triples' = triples lim
        lim = max 4 (maximum input)
        isSubset triple = subset `Set.isSubsetOf` (Set.fromList $ sanwa 3 triple)
        subset = Set.fromList input

triples :: Int -> [[Int]]
triples lim = do
    a <- [1   .. lim-2]
    b <- [a+1 .. lim-1]
    c <- [b+1 .. lim]
    return [a, b, c]

output :: [[Int]] -> String
output (_:_:_) = "many"
output (x:_)   = intercalate "," $ map show x
output []      = "none"

sanwa :: Int -> [Int] -> [Int]
sanwa 1 xs = xs
sanwa n xs = concat xss
    where
        xss = do
            (x', xs') <- zip xs (tails xs)
            return $ x' : map (+ x') (sanwa (n - 1) xs')


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "3,11,12,102,111,120"                 "1,10,100"
    test "10,20,30,35,70"                      "many"
    test "1,5,20,80"                           "none"
    test "1,2,3,4,5,6,7,8,9,10,11,12,13,14"    "many"
    test "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" "1,4,5"
    test "1,2,3,4,5,6,7,8,9,10,11,12,13,14,17" "none"
    test "1,2,3,4,5,6,7,8,9,10,11,12,13,14,18" "1,4,6"
    test "5,6,7,8,9,10,11,12,13,14,15,16"      "2,5,6"
    test "9,10,11,12,13,14,15,16,17,18,19"     "4,5,7"
    test "11,36,37,45,55,70,71"                "1,10,35"
    test "92,93,94,95,96,97,98,99"             "30,32,33"
    test "95,96,97,98,99,100"                  "many"
    test "27,30,34,37,43,44,46,51,57"          "10,17,23"
    test "6,10,13,17,65,73,76,80"              "none"
    test "12,19,21,29,85"                      "none"
    test "1,2,8,10,14,23,58,62,64"             "none"
    test "4,22,25,31,44,50,58,69,71,72,73,77"  "none"
    test "8,16,26,27,42,53,65,69,81,83,88,99"  "none"
    test "9,10,23,24,28,33,38,39,58,68,84"     "none"
    test "11,16,24,26,88"                      "none"
    test "24,33,47,56,63,66,75,78,89,93"       "none"
    test "7,26,72,77"                          "many"
    test "69,88,95,97"                         "many"
    test "9,14,48,89"                          "many"
    test "69,76,77,83"                         "many"
    test "11,14,24"                            "many"
    test "8,25,75,93"                          "many"
    test "11,55,93,98,99"                      "many"
    test "71,83,87"                            "many"
    test "22,76,77,92"                         "7,15,62"
    test "33,61,66,83,95"                      "17,33,61"
    test "6,16,49,55,72"                       "6,16,33"
    test "62,85,97,98"                         "12,25,73"
    test "54,60,67,70,72"                      "20,25,27"
    test "54,61,68,84,87"                      "27,30,34"
    test "65,67,69,75,79,89,99"                "21,23,33"
    test "69,72,80,81,89"                      "23,24,33"
    test "1,2,3"                               "many"
