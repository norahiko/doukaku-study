-- 第2回 オフラインリアルタイムどう書くの参考問題
-- 二値画像の回転
-- http://qiita.com/Nabetani/items/9d80de41903775296ca6

-- 文字列 -> 2次元配列 -> 回転 -> 2次元配列 -> 文字列 という流れで解きました。
-- 面倒ですが特に難しいところはなかったと思います。

import Data.Char (digitToInt, intToDigit)
import Data.Bits (testBit)
import Data.List (transpose)
import Data.List.Split (chunksOf)

type Image = [[Bool]]

rotateRight :: Image -> Image
rotateRight = map reverse . transpose

decode :: Int -> String -> Image
decode size hex = take size $ chunksOf size $ concat (map hexToBin hex)

encode :: Image -> String
encode img = map binToHex $ chunksOf 4 $ concat img

hexToBin :: Char -> [Bool]
hexToBin h = map (testBit (digitToInt h)) [3, 2, 1, 0]

binToHex :: [Bool] -> Char
binToHex bin = intToDigit $ iter 0 bin'
    where
        bin'          = take 4 (bin ++ [False, False, False])
        iter n []     = n
        iter n (x:xs) = iter (n * 2 + (if x then 1 else 0)) xs

solve :: String -> String
solve input = do
    (size, (':':hex)) <- reads input :: [(Int, String)]
    show size ++ ':' : encode (rotateRight $ decode size hex)

test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "3:5b8"                   "3:de0"
    test "1:8"                     "1:8"
    test "2:8"                     "2:4"
    test "2:4"                     "2:1"
    test "2:1"                     "2:2"
    test "3:5d0"                   "3:5d0"
    test "4:1234"                  "4:0865"
    test "5:22a2a20"               "5:22a2a20"
    test "5:1234567"               "5:25b0540"
    test "6:123456789"             "6:09cc196a6"
    test "7:123456789abcd"         "7:f1a206734b258"
    test "7:fffffffffffff"         "7:ffffffffffff8"
    test "7:fdfbf7efdfbf0"         "7:ffffffffffc00"
    test "8:123456789abcdef1"      "8:f0ccaaff78665580"
    test "9:112233445566778899aab" "9:b23da9011d22daf005d40"
