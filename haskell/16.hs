-- オフラインリアルタイムどう書く第16回の問題
-- 境界線分
-- http://qiita.com/Nabetani/items/6a9f5593d0f3d7e0568c
--
-- 2重ループで解きたくなるような問題ですが、Haskellではどう書けばいいのかわからず。
-- いろいろとひどいコードを書きました。
-- splitOnを発見してからは楽でした。

import Data.Bits (testBit)
import Data.Char (digitToInt)
import Data.List (intercalate)
import Data.List.Split (splitOn, chunksOf)


octalToBools :: Char -> [Bool]
octalToBools oct = map (\b -> testBit (digitToInt oct) b) [2, 1, 0]

concatEdges :: [[Bool]] -> [[Bool]]
concatEdges edges = concatMap (splitOn [False]) edges

solve :: String -> String
solve input = intercalate "," $ map show result
    where
        cells       = chunksOf 6 $ concatMap octalToBools input
        get y x     = cells !! y !! x
        verticals   = [[get y x /= get y (x+1) | y <- [0..5]] | x <- [0..4]]
        horizontals = [[get y x /= get (y+1) x | x <- [0..5]] | y <- [0..4]]
        edges       = concatEdges (verticals ++ horizontals)
        sizes       = map length $ edges
        result      = map (\n -> length $ filter (== n) sizes) [1..6]


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "060276724276" "6,2,1,1,0,1"
    test "770175454177" "2,3,0,3,1,0"
    test "743733377170" "9,3,1,0,0,0"
    test "724212121273" "5,2,1,1,1,1"
    test "100000000000" "3,0,0,0,0,0"
    test "000002000000" "4,0,0,0,0,0"
    test "003622223600" "0,4,0,4,0,0"
    test "520073737070" "8,3,1,1,0,0"
    test "770077007700" "0,0,0,0,0,5"
    test "555555555514" "2,0,0,0,2,2"
    test "764252427600" "4,0,4,0,2,0"
    test "774555554177" "3,3,1,3,0,0"
    test "674574754557" "11,5,0,1,0,0"
    test "000000000000" "0,0,0,0,0,0"
    test "777777777777" "0,0,0,0,0,0"
    test "774377777577" "6,0,2,0,0,0"
    test "070777777777" "0,1,1,0,0,0"
    test "373737373737" "0,0,0,0,0,1"
    test "603260327725" "30,0,0,0,0,0"
    test "466331144663" "30,0,0,0,0,0"
    test "000000000242" "3,2,0,0,0,0"
    test "567656043772" "18,2,1,0,0,0"
    test "200763012420" "15,4,1,0,0,0"
    test "400101140052" "14,3,0,0,0,0"
    test "764767476476" "13,2,0,1,0,0"
    test "001110140110" "12,2,1,0,0,0"
    test "765405076527" "16,3,0,1,0,0"
    test "377323370373" "8,4,2,0,0,0"
    test "250541131216" "11,5,2,0,0,0"
    test "744165741476" "12,3,2,0,0,0"
    test "042101000300" "10,3,0,0,0,0"
    test "002004554101" "11,3,1,0,0,0"
    test "371707762706" "15,1,1,0,0,0"
    test "130371310175" "7,3,1,2,0,0"
    test "212537003613" "13,2,1,1,1,0"
    test "157700063411" "15,3,0,0,0,1"
    test "011500036007" "6,7,1,0,0,0"
    test "743113313517" "17,2,1,0,0,0"
    test "174105270405" "13,3,1,1,0,0"
    test "427272200311" "13,3,2,0,0,0"
    test "725370332237" "12,5,1,1,0,0"
    test "005640420046" "12,1,3,0,0,0"
    test "700350001101" "14,3,1,0,0,0"
    test "577627744076" "16,1,1,1,0,0"
    test "620332232007" "10,4,2,1,0,0"
    test "260406401000" "15,1,1,0,0,0"
    test "737272723276" "5,0,0,0,3,0"
    test "000400040444" "7,0,2,0,0,0"
    test "370222002177" "13,2,2,0,0,0"
    test "372236024656" "9,3,2,0,1,0"
    test "276131137003" "11,6,2,0,0,0"
    test "742134007240" "13,4,2,0,0,0"
    test "777721775571" "13,1,2,0,0,0"
    test "700301232233" "11,2,3,0,0,0"
