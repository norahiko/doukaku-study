-- オフラインリアルタイムどう書く第13回の参考問題
-- 増やす減らす二倍する
-- http://qiita.com/Nabetani/items/89fb0e2e712d4b396535


calc :: [(Int, Int)] -> String
calc ((step, num) : queue)
    | num == 0  = show step
    | even num  = calc (queue ++ [(step+1, num `div` 2)])
    | otherwise = calc (queue ++ [(step+1, num+1), (step+1, num-1)])

solve :: String -> String
solve input = calc [(0, read input)]

test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "59"     "9"
    test "10"     "5"
    test "11"     "6"
    test "12"     "5"
    test "13"     "6"
    test "14"     "6"
    test "15"     "6"
    test "16"     "5"
    test "17"     "6"
    test "18"     "6"
    test "27"     "8"
    test "28"     "7"
    test "29"     "8"
    test "30"     "7"
    test "31"     "7"
    test "32"     "6"
    test "33"     "7"
    test "34"     "7"
    test "35"     "8"
    test "41"     "8"
    test "71"     "9"
    test "1023"   "12"
    test "1024"   "11"
    test "1025"   "12"
    test "1707"   "17"
    test "683"    "15"
    test "123"    "10"
    test "187"    "11"
    test "237"    "12"
    test "5267"   "18"
    test "6737"   "18"
    test "14796"  "20"
    test "18998"  "20"
    test "23820"  "20"
    test "30380"  "21"
    test "31119"  "21"
    test "33301"  "20"
    test "33967"  "21"
    test "35443"  "22"
    test "35641"  "22"
    test "43695"  "23"
    test "44395"  "23"
    test "44666"  "22"
    test "987"    "14"
    test "1021"   "13"
    test "1019"   "13"
    test "1015"   "13"
    test "1007"   "13"
    test "1011"   "14"
    test "1003"   "14"
    test "983"    "14"
    test "999"    "14"
    test "2731"   "18"
    test "6827"   "20"
    test "10923"  "21"
    test "27307"  "23"
    test "43691"  "24"
    test "109227" "26"
    test "174763" "27"
