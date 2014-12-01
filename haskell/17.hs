-- オフラインリアルタイムどう書く第17回の問題
-- 折って切る
-- http://qiita.com/Nabetani/items/ebd9d7deb30c57447806

-- 
-- 個人的には最も難しい問題でした。
-- 最初、4辺の紙の枚数を数える方法で解こうとしましたが、
-- 3つのテストケースがいつまでたっても通らず、
-- 結局ヒントを見て書きました。
--
data Cut = Tr | Tl | Br | Bl | T | B | R | L | Diamond deriving (Eq, Show)

open :: Char -> Cut -> [Cut]
open _ Diamond = [Diamond, Diamond]

open 'T' cut = case cut of
    Tr -> [R]
    Tl -> [L]
    Br -> [Tr, Br]
    Bl -> [Tl, Bl]
    T  -> [Diamond]
    B  -> [T, B]
    R  -> [R, R]
    L  -> [L, L]

open 'B' cut = case cut of
    Tr -> [Tr, Br]
    Tl -> [Tl, Bl]
    Br -> [R]
    Bl -> [L]
    T  -> [T, B]
    B  -> [Diamond]
    R  -> [R, R]
    L  -> [L, L]

open 'R' cut = case cut of
    Tr -> [T]
    Tl -> [Tr, Tl]
    Br -> [B]
    Bl -> [Br, Bl]
    T  -> [T, T]
    B  -> [B, B]
    R  -> [Diamond]
    L  -> [R, L]

open 'L' cut = case cut of
    Tr -> [Tr, Tl]
    Tl -> [T]
    Br -> [Br, Bl]
    Bl -> [B]
    T  -> [T, T]
    B  -> [B, B]
    R  -> [R, L]
    L  -> [Diamond]

openAll :: Char -> [Cut] -> [Cut]
openAll dir cuts = concatMap (open dir) cuts


solve input = show result
    where
        (order, '-':c) = break (== '-') input
        cut = case c of
            "tr" -> [Tr]
            "tl" -> [Tl]
            "br" -> [Br]
            "bl" -> [Bl]
        opened = foldr openAll cut order
        result = length $ filter (== Diamond) opened


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "RRTRB-bl"   "6"
    test "R-tr"       "0"
    test "L-br"       "0"
    test "T-tl"       "0"
    test "B-tl"       "0"
    test "BL-br"      "0"
    test "LB-tl"      "0"
    test "RL-tl"      "0"
    test "BL-tl"      "0"
    test "TL-bl"      "0"
    test "RT-tr"      "1"
    test "TRB-tl"     "0"
    test "TRL-bl"     "0"
    test "TRB-br"     "2"
    test "LLB-bl"     "2"
    test "RTL-tr"     "1"
    test "LBB-tr"     "0"
    test "TLL-tl"     "2"
    test "RLRR-tr"    "0"
    test "BBTL-tl"    "4"
    test "TBBT-tr"    "0"
    test "LLBR-tl"    "0"
    test "LBRT-tl"    "2"
    test "RLBL-bl"    "4"
    test "BRRL-br"    "3"
    test "TBBTL-tl"   "8"
    test "TLBBT-br"   "0"
    test "LRBLL-br"   "7"
    test "TRRTT-br"   "6"
    test "BBBLB-br"   "0"
    test "RTTTR-tl"   "4"
    test "BBLLL-br"   "6"
    test "RRLLTR-tr"  "16"
    test "TTRBLB-br"  "8"
    test "LRBRBR-bl"  "14"
    test "RBBLRL-tl"  "8"
    test "RTRLTB-tl"  "12"
    test "LBLRTR-tl"  "14"
    test "RRLTRL-tl"  "16"
    test "TBLTRR-br"  "12"
    test "TTTRLTT-bl" "30"
    test "TBBRTBL-tr" "15"
    test "TRTRTLL-tr" "28"
    test "TLLRTRB-tr" "24"
    test "RLLBRLB-tr" "15"
    test "LTLRRBT-tr" "32"
    test "RBBRBLT-br" "21"
    test "LLRLRLR-tr" "0"
