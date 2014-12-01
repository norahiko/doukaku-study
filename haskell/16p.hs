-- オフラインリアルタイムどう書く第16回の参考問題
-- L被覆
-- http://qiita.com/Nabetani/items/7be4bc2a3514bbfbfc15

-- 全ての黒マスを含む四角形から四隅から最も大きな四角形を一つ削ります。
-- もっと簡単に溶けないかいろいろ考えましたがわからず。。。結構手こずりました。

import Data.Char
import Data.List
import Data.List.Split

type Dot = (Int, Int)

type Rect = (Int, Int, Int, Int)

has :: [Dot] -> Rect -> Bool
has dots (ax, ay, bx, by) = any (\(x, y) -> ax <= x && x <= bx && ay <= y && y <= by) dots

rectArea :: Rect -> Int
rectArea (ax, ay, bx, by) = (bx - ax + 1) * (by - ay + 1)

parse :: String -> [Dot]
parse input               = map (\[x, y] -> (digitToInt x, digitToInt y)) $ splitOn "," input

solve :: String -> String
solve input
    | length dots == 1 = "3"
    | dots == corners  = "-"
    | otherwise        = case cornerAreas of
        [] -> show $ wholeRectArea + 1
        cs -> show $ wholeRectArea - maximum cs

    where
        dots          = nub $ sort $ parse input
        corners       = [(0, 0), (0, 9), (9, 0), (9, 9)]
        dotsX         = map fst dots
        dotsY         = map snd dots

        minX          = minimum $ dotsX
        minY          = minimum $ dotsY
        maxX          = maximum $ dotsX
        maxY          = maximum $ dotsY
        wholeRectArea = rectArea (minX, minY, maxX, maxY)

        cornerRects :: [Rect]
        cornerRects = (do
            x <- [minX..maxX]
            y <- [minY..maxY]
            [(minX, minY, x, y), (x, minY, maxX, y), (minX, y, x, maxY), (x, y, maxX, maxY)])

        cornerRects' = filter (not . has dots) cornerRects
        cornerAreas  = map rectArea cornerRects'


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "41,33,26,55,74,58,68"                                              "39"
    test "00,99,09,90"                                                       "-"
    test "09"                                                                "3"
    test "05,05,05"                                                          "3"
    test "45"                                                                "3"
    test "38,39"                                                             "3"
    test "38,47"                                                             "3"
    test "45,66"                                                             "4"
    test "12,34,56,78"                                                       "33"
    test "12,34,56,78,45"                                                    "37"
    test "00,09,00"                                                          "11"
    test "00,90"                                                             "11"
    test "99,09"                                                             "11"
    test "99,90"                                                             "11"
    test "11,12,21,22"                                                       "5"
    test "42,45,92,95,83,62"                                                 "25"
    test "42,45,92,83,62"                                                    "14"
    test "34,38,78,74,56,35,77,48,54"                                        "26"
    test "38,78,74,56,35,77,48,54"                                           "23"
    test "31,41,21,71,21"                                                    "7"
    test "46,45,42,44,45"                                                    "6"
    test "00,99,09"                                                          "19"
    test "99,09,90,24"                                                       "64"
    test "99,16,61,34,17,24,42,26,18,71,19,91,81,43,33,62,52,25"             "75"
    test "55,43,16,91,61,19,24,18,33,34,71,81,42,62,52,26,17,25"             "53"
    test "71,26,81,62,17,16,25,42,33,52,19,18,91,24,61,34,43"                "45"
    test "39,49,19,93,78,58,48,91,95,29,68,92,86,87,94,77"                   "39"
    test "69,89,25,26,58,12,37,36,68,24,11,13,48,14,79"                      "37"
    test "58,67,92,38,83,29,91,76,84,57,75,48,85,19,66"                      "51"
    test "00,83,76,85,48,19,75,29,92,57,66,67,91,58,38,84"                   "91"
    test "11,92,57,38,58,66,91,67,84,48,83,19,75,85,76,29"                   "72"
    test "36,07,45"                                                          "9"
    test "57,23,24,74"                                                       "21"
    test "92,20,32,12,65"                                                    "39"
    test "24,54,66,48,54,15"                                                 "21"
    test "05,17,42,20,48,22,13"                                              "39"
    test "53,84,55,56,25,14,84,43"                                           "26"
    test "06,77,56,59,15,24,09,66,71"                                        "51"
    test "53,36,47,45,45,67,66,46,63,75"                                     "21"
    test "35,53,93,33,02,84,83,48,54,32,28"                                  "50"
    test "55,74,32,84,41,64,24,44,15,14,26,53"                               "39"
    test "47,60,34,32,19,67,24,83,94,38,47,05,79"                            "88"
    test "63,32,42,74,66,64,35,41,74,25,48,62,44,54"                         "42"
    test "00,86,16,19,09,92,51,10,68,23,14,63,21,46,03"                      "91"
    test "56,46,54,14,15,25,53,84,58,85,44,37,54,76,26,76"                   "42"
    test "71,87,39,43,76,38,91,69,98,33,43,26,56,69,73,52,89"                "66"
    test "43,26,84,64,52,48,36,23,66,53,41,57,76,36,84,57,35,41"             "47"
    test "81,02,85,93,36,46,80,27,72,28,02,99,13,41,36,40,18,97,38"          "91"
    test "63,46,75,58,42,26,58,37,14,75,35,63,32,36,52,46,85,14,48,23"       "47"
    test "66,92,64,12,17,33,10,28,75,05,81,05,42,86,52,57,56,78,87,81,10"    "82"
    test "48,25,58,76,15,74,43,44,24,62,33,67,34,34,42,48,37,33,51,43,46,67" "50"
