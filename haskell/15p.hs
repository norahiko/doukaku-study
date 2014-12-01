-- オフラインリアルタイムどう書く第15回の参考問題
-- 回分の発掘
-- http://qiita.com/Nabetani/items/0b56395d4c9e7c64b230

import Data.List


-- JavaScriptで実装した後で2番目のコードを短くなるように書き直したコード。
-- reverseを多用しているので少し遅い。

palindrome :: String -> Int
palindrome str = maximum $ do
        (h:rest) <- tails str
        let r = dropWhile (/= h) $ reverse rest
        case r of
            []     -> return 1
            [_]    -> return 2
            (_:xs) -> return $ 2 + palindrome (reverse xs)
--
solve :: String -> String
solve = show . palindrome


-- 2番目に書いた解答
-- 両端から共通した文字を削っていく方法
--
-- commonPrefixLength :: Eq a => [a] -> [a] -> Int
-- commonPrefixLength (x:xs) (y:ys) = if x /= y then 0 else 1 + commonPrefixLength xs ys
-- commonPrefixLength _ _ = 0
-- 
-- kaibun :: Eq a => Int -> [a] -> [a] -> Int
-- kaibun len [] _ = len
-- kaibun len str rev = len'
--     where
--         len' = case commonPrefixLength str rev of
--             0 -> max a b
--             p -> kaibun (len + p) (drop p str) (drop p rev)
--         a = kaibun len (tail str) rev
--         b = case elemIndex (head str) rev of
--             Nothing -> 0
--             Just i  -> kaibun (len + 1) (tail str) (drop (i + 1) rev)
-- 
-- solve :: String -> String
-- solve input = show $ kaibun 0 input (reverse input)

-- 最初に思いついた解答
-- とても短いがsubsequencesが爆発的に増えるので15文字を超えたあたりで計算が終わらなくなるのでボツ。
--
-- solve input = show $ maximum [length xs | xs <- subsequences input, xs == reverse xs]


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "I_believe_you_can_solve"        "9"
    test "a"                              "1"
    test "aa"                             "2"
    test "aaa"                            "3"
    test "ab"                             "1"
    test "aabb"                           "2"
    test "ABBA"                           "4"
    test "Abba"                           "2"
    test "1234567890"                     "1"
    test "1234567890987654321"            "19"
    test "abcdcba"                        "7"
    test "0a1b2c3d4c5b6a7"                "7"
    test "abcdcba0123210"                 "7"
    test "abcdcba_123210"                 "7"
    test "_bcdcba0123210"                 "7"
    test "abcddcba0123210"                "8"
    test "abcdcba01233210"                "8"
    test "a0bc1dc2ba3210a"                "9"
    test "a0bc1ddc2ba3210"                "8"
    test "3a0bc1ddc2ba3210"               "10"
    test "11oooo1111o1oo1o111ooooooooooo" "20"
    test "11o1111o1111oo11ooo11111ooo1oo" "20"
    test "111111oo11o111ooo1o1ooo11ooo1o" "21"
    test "11o1o1o11oo11o11oo111o1o1o11oo" "27"
    test "oo111o1o11o1oo1ooo11o1o11o1o1o" "27"
    test "1o1oo11111o1o1oo1o1o1111oo1o1o" "28"
    test "QQooooQooooQQyQoyQQQyyyyQQoyoy" "15"
    test "oQoooQooooQyoyQoyoyyyQQyQQQQoQ" "16"
    test "yyyyyooyQyyyoyyQyyooyQoQoQQoQy" "17"
    test "yyQoyQoyyQyQQoyooooyyQQyQyooQy" "24"
    test "oQQooQoQyQQoyoQQoQyQyQyQoQoooo" "24"
    test "oQQyQQyyQyQQoooyQQyyyQQQyyQQoy" "25"
    test "WAk9iHI4jVDlStyudwTNqE138kwan2" "3"
    test "c43fIu1Mlz0K9hEVOgGcUdbeB5ksa7" "3"
    test "CAbYcW5VqHjzFdIkH_61PM0TsyRuie" "3"
    test "jInQnUvSayrJTsQWujovbbqW0STvoj" "10"
    test "iZDrvpUKgtj3FrZsZ4CLjrEgUdZzQG" "11"
    test "ROgYUOu6er_DA7nB6UGquO1GUHC62R" "11"
    test "Oh_be_a_fine_girl_kiss_me"      "9"
    test "8086_6502_6809_Z80"             "11"
    test "xcode_visualstudio_eclipse"     "11"
    test "word_excel_powerpoint_outlook"  "9"
    test "abcdefghijklmnopqrstuvwxyz0123" "1"
