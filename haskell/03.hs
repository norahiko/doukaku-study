-- オフラインリアルタイムどう書く第3回の問題
-- Y字路巡り
-- http://nabetani.sakura.ne.jp/hena/ord3ynode/

import Data.List (elemIndex)

graph :: Char -> String
graph node = case node of
    'A' -> "BCD"
    'B' -> "CAE"
    'C' -> "ABF"
    'D' -> "EAF"
    'E' -> "FBD"
    'F' -> "CED"
    _   -> error "invalid"

walk :: String -> Char -> Char -> String
walk [] _ to         = [to]
walk (x:xs) from to  = to : walk xs to next
    where
        nextNodes  = graph to
        Just index = elemIndex from nextNodes
        Just dir   = elemIndex x "brl"
        next       = cycle nextNodes !! (index + dir)

solve :: String -> String
solve input = walk input 'B' 'A'


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "b"               "AB"
    test "l"               "AD"
    test "r"               "AC"
    test "bbb"             "ABAB"
    test "rrr"             "ACBA"
    test "blll"            "ABCAB"
    test "llll"            "ADEBA"
    test "rbrl"            "ACADE"
    test "brrrr"           "ABEDAB"
    test "llrrr"           "ADEFDE"
    test "lrlll"           "ADFEDF"
    test "lrrrr"           "ADFCAD"
    test "rllll"           "ACFDAC"
    test "blrrrr"          "ABCFEBC"
    test "brllll"          "ABEFCBE"
    test "bbrllrrr"        "ABACFDEFD"
    test "rrrrblll"        "ACBACABCA"
    test "llrlrrbrb"       "ADEFCADABA"
    test "rrrbrllrr"       "ACBABEFCAD"
    test "llrllblrll"      "ADEFCBCADEB"
    test "lrrlllrbrl"      "ADFCBEFDFCB"
    test "lllrbrrlbrl"     "ADEBCBACFCAB"
    test "rrrrrrlrbrl"     "ACBACBADFDEB"
    test "lbrbbrbrbbrr"    "ADABABEBCBCFE"
    test "rrrrlbrblllr"    "ACBACFCACFDAB"
    test "lbbrblrlrlbll"   "ADADFDABCFDFED"
    test "rrbbrlrlrblrl"   "ACBCBADFEBEFDA"
    test "blrllblbrrrrll"  "ABCFDADEDABEDFE"
    test "blrllrlbllrrbr"  "ABCFDABCBEFDEDA"
    test "lbrbbrllllrblrr" "ADABABEFCBEDEBCF"
    test "rrrrbllrlrbrbrr" "ACBACABCFDEDADFC"
