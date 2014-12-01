-- オフラインリアルタイムどう書く第6回の問題
-- 続柄
-- http://nabetani.sakura.ne.jp/hena/ord6kinship/

-- floor((N + 1) / 3) でNの親の数字が得られます。
-- さらに二人の親同士または親の親などをを比較すると続柄が分かります。

-- いろいろと試行錯誤しましたが、親の数字の求め方がわかれば簡単でした。


import Data.List.Split (splitOn)

parent :: Int -> Int
parent n = (n + 1) `div` 3

match :: (Int, Int) -> String
match (a, b)
    | a                 == b                 = "me"
    | parent a          == b                 = "mo"
    | parent b          == a                 = "da"
    | parent a          == parent b          = "si"
    | parent (parent a) == parent b          = "au"
    | parent a          == parent (parent b) = "ni"
    | parent (parent a) == parent (parent b) = "co"
    | otherwise                              = "-"

parse :: String -> (Int, Int)
parse input = let [from, to] = (splitOn "->" input)
              in (read from, read to)

solve :: String -> String
solve = match . parse


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "5->2"   "mo"
    test "28->10" "au"
    test "1->1"   "me"
    test "40->40" "me"
    test "27->27" "me"
    test "7->2"   "mo"
    test "40->13" "mo"
    test "9->3"   "mo"
    test "4->1"   "mo"
    test "1->3"   "da"
    test "12->35" "da"
    test "3->8"   "da"
    test "6->19"  "da"
    test "38->40" "si"
    test "9->8"   "si"
    test "4->2"   "si"
    test "15->16" "si"
    test "40->12" "au"
    test "10->4"  "au"
    test "21->5"  "au"
    test "8->2"   "au"
    test "3->5"   "ni"
    test "11->39" "ni"
    test "2->13"  "ni"
    test "13->32" "ni"
    test "14->22" "co"
    test "40->34" "co"
    test "5->8"   "co"
    test "12->10" "co"
    test "1->27"  "-"
    test "8->1"   "-"
    test "12->22" "-"
    test "2->40"  "-"
    test "32->31" "-"
    test "13->14" "-"
