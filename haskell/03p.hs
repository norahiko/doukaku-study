-- オフラインリアルタイムどう書く第3回の参考問題
-- ボールカウント(野球)
-- http://qiita.com/Nabetani/items/ebd8a56b41711ba459f9

import Data.Char (intToDigit)
import Data.List (intercalate)

type BaseBall = (Int, Int, Int)

showBaseBall :: BaseBall -> String
showBaseBall (o, s, b) = [intToDigit o, intToDigit s, intToDigit b]

fixBall :: BaseBall -> BaseBall
fixBall (o, _, 4) = (o, 0, 0)
fixBall bb        = bb

fixStrike :: BaseBall -> BaseBall
fixStrike (o, 3, _) = (o + 1, 0, 0)
fixStrike bb        = bb

fixOut :: BaseBall -> BaseBall
fixOut (3, _, _) = (0, 0, 0)
fixOut bb        = bb

play :: BaseBall -> Char -> BaseBall
play (o, s, b) event = case event of
    's' -> (o    , s + 1        , b)
    'b' -> (o    , s            , b + 1)
    'f' -> (o    , min 2 (s + 1), b)
    'h' -> (o    , 0            , 0)
    'p' -> (o + 1, 0            , 0)
    _   -> error "invalid"

solve :: String -> String
solve input = intercalate "," (map showBaseBall result)
    where
        result  = tail $ scanl iter (0, 0, 0) input
        iter bb = fixOut . fixStrike . fixBall . play bb


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "s"               "010"
    test "sss"             "010,020,100"
    test "bbbb"            "001,002,003,000"
    test "ssbbbb"          "010,020,021,022,023,000"
    test "hsbhfhbh"        "000,010,011,000,010,000,001,000"
    test "psbpfpbp"        "100,110,111,200,210,000,001,100"
    test "ppp"             "100,200,000"
    test "ffffs"           "010,020,020,020,100"
    test "ssspfffs"        "010,020,100,200,210,220,220,000"
    test "bbbsfbppp"       "001,002,003,013,023,000,100,200,000"
    test "sssbbbbsbhsbppp" "010,020,100,101,102,103,100,110,111,100,110,111,200,000,100"
    test "ssffpffssp"      "010,020,020,020,100,110,120,200,210,000"
