-- オフラインリアルタイムどう書く第12回の参考問題
-- 道なりの亀
-- http://qiita.com/Nabetani/items/1de39df381dfeee305ab

-- 地図を2つつなげてXY座標系の問題として解けるように単純化しました。

import Data.Char

type Vec = (Int, Int)


mapData :: [String]
mapData = ["?????????????",
           "?ABCDEFGHIJK?",
           "?LMNOPQRSTUV?",
           "?WXYZabcdefg?",
           "?hij?????765?",
           "?klm?????432?",
           "?nop?????10z?",
           "?qrs?????yxw?",
           "?tuv?????vut?",
           "?wxy?????srq?",
           "?z01?????pon?",
           "?234?????mlk?",
           "?567?????jih?",
           "?gfedcbaZYXW?",
           "?VUTSRQPONML?",
           "?KJIHGFEDCBA?",
           "?????????????"]

turn :: Char -> Vec -> Vec
turn 'L' (x, y) = (y, -x)
turn 'R' (x, y) = (-y, x)
turn _ _         = error "invalid"

goAhead :: String -> Vec -> Vec -> Int -> String
goAhead moves vec@(vx, vy) pos@(x, y) n
    | cur == '?' = "?"
    | n == 0     = walk moves vec pos
    | otherwise  = cur : goAhead moves vec (x+vx, y+vy) (n - 1)
    where
        cur = mapData !! y !! x

walk :: String -> Vec -> Vec -> String
walk [] _ (x, y) = [mapData !! y !! x]
walk (m:moves) vec pos
    | isHexDigit m = goAhead moves vec pos (digitToInt m)
    | otherwise    = walk moves (turn m vec) pos

solve :: String -> String
solve input = walk input (1, 0) (1, 1)


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "2RcL3LL22"                         "ABCNYjmpsvy147edcbcdef"
    test "L3R4L5RR5R3L5"                     "A?"
    test "2ReLLe"                            "ABCNYjmpsvy147eTITe741yvspmjYNC"
    test "1ReRRe"                            "ABMXilorux036fUJUf630xuroliXMB"
    test "ReRRe"                             "ALWhknqtwz25gVKVg52zwtqnkhWLA"
    test "f"                                 "ABCDEFGHIJK?"
    test "Rf"                                "ALWhknqtwz25gVK?"
    test "1Rf"                               "ABMXilorux036fUJ?"
    test "2Rf"                               "ABCNYjmpsvy147eTI?"
    test "aR1RaL1LaR1R2L1L2"                 "ABCDEFGHIJKVUTSRQPONMLWXYZabcdefg567432"
    test "2R1R2L1L2R1R2L1L2R1R2L1L2R1R2L1L2" "ABCNMLWXYjihklmponqrsvutwxy"
    test "2R4R2L4L2R4R2L4L2R4R2L4L2"         "ABCNYjmlknqtwxy147efgVK?"
    test "R1L2R4R2L4L2R4R2L4L2R4R2L4L2"      "ALMNYjmponqtwz0147eTUVK?"
    test "R2L2R4R2L4L2R4R2L4L2R4R2L4L2"      "ALWXYjmpsrqtwz2347eTIJK?"
    test "R3L2R4R2L4L2R4R2L4L2R4R2L4L2"      "ALWhijmpsvutwz2567eTI?"
    test "R5L2L5L1LaR1L4L5"                  "ALWhknopmjYNCBMXilorux0325gVKJIHGF"
    test "1R2L4L2R4R2L4L2R4"                 "ABMXYZabQFGHIJUfg?"
    test "2R2L4L2R4R2L4L2R4"                 "ABCNYZabcRGHIJKVg?"
    test "3R2L4L2R4R2L4L2R4"                 "ABCDOZabcdSHIJK?"
    test "4R2L4L2R4R2L4L2R4"                 "ABCDEPabcdeTIJK?"
    test "5R2L4L2R4R2L4L2R4"                 "ABCDEFQbcdefUJK?"
    test "LLL1RRR1LLL1RRR2R1"                "ALMXYZ?"
    test "R3RRR3"                            "ALWhij?"
    test "1LLL4RRR1LR1RL1"                   "ABMXilm?"
    test "R2L1R2L1R3R4"                      "ALWXilmpsvut?"
    test "7R4f47LLLc6R9L"                    "ABCDEFGHSd?"
    test "5RR868L8448LL4R6"                  "ABCDEFEDCBA?"
    test "42Rd1RLLa7L5"                      "ABCDEFGRc?"
    test "RRLL6RLR1L5d12LaLRRL529L"          "ABCDEFGRSTUV?"
    test "RLR7L6LL1LRRRcRL52R"               "ALWhknqtuv?"
    test "1RLR8RLR1R437L99636R"              "ABMXiloruxwtqnkhWLA?"
    test "LLL2L3La9Le5LRR"                   "ALWXYZOD?"
    test "R1LcRR491"                         "ALMNOPQRSTUV?"
    test "R8L1R1R512L8RLLReRf"               "ALWhknqtwx0z?"
    test "1RcL8f1L29a5"                      "ABMXilorux036fedcbaZYXW?"
    test "R822LeL46LL39LL"                   "ALWhknqtwz25gfedcbaZYXW?"
    test "9R3L5LRRLb5R3L7cLLLR4L"            "ABCDEFGHIJUf65?"
    test "7LLRRR2R3R69Lf76eR2L"              "ABCDEFGHSdcbaPE?"
    test "8RRRLL3Le"                         "ABCDEFGHITe765?"
    test "8R5RLL6LbL4LL5bL"                  "ABCDEFGHITe7410z?"
    test "6LR2R1LR5LRLRL484L63"              "ABCDEFGHITe741yxw?"
