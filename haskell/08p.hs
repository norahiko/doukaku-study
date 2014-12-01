-- オフラインリアルタイムどう書く第8回の参考問題
-- エントロピー符号
-- http://nabetani.sakura.ne.jp/hena/ord8entco/

import Data.Char
import Data.List
import Data.Bits

hexToBin :: Char -> String
hexToBin hex = map (\b -> if testBit (digitToInt hex) b then '1' else '0') [0..3]

codeTable :: [(String, Char)]
codeTable = [
    ("000"    , 't'),
    ("0010"   , 's'),
    ("0011"   , 'n'),
    ("0100"   , 'i'),
    ("01010"  , 'd'),
    ("0101101", 'c'),
    ("010111" , 'l'),
    ("0110"   , 'o'),
    ("0111"   , 'a'),
    ("10"     , 'e'),
    ("1100"   , 'r'),
    ("1101"   , 'h')]

decrypt' :: Int -> String -> String -> String
decrypt' len bin text = case find ((`isPrefixOf` bin) . fst) codeTable of
    Just (code, ch) -> let len'  = len + length code
                           bin'  = drop (length code) bin
                           text' = ch : text
                       in decrypt' len' bin' text'

    Nothing         -> if "111" `isPrefixOf` bin
                           then reverse text ++ ":" ++ show (len + 3)
                           else "*invalid*"

decrypt :: String -> String
decrypt b = decrypt' 0 b ""

solve :: String -> String
solve = decrypt . (concatMap hexToBin)


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "16d9d4fbd"      "ethanol:30"
    test "df"             "e:5"
    test "ad7"            "c:10"
    test "870dcb"         "t:6"
    test "880f63d"        "test:15"
    test "a57cbe56"       "cat:17"
    test "36abef2"        "roll:23"
    test "ad576cd8"       "chant:25"
    test "3e2a3db4fb9"    "rails:25"
    test "51aa3b4c2"      "eeeteee:18"
    test "ad5f1a07affe"   "charset:31"
    test "4ab8a86d7afb0f" "slideshare:42"
    test "ac4b0b9faef"    "doctor:30"
    test "cafebabe"       "nlh:17"
    test "43e7"           "sra:15"
    test "53e7"           "eera:15"
    test "86cf"           "tera:16"
    test "b6cf"           "hon:15"
    test "0"              "*invalid*"
    test "c"              "*invalid*"
    test "d"              "*invalid*"
    test "e"              "*invalid*"
    test "babecafe"       "*invalid*"
    test "8d"             "*invalid*"
    test "ad"             "*invalid*"
    test "af"             "*invalid*"
    test "ab6e0"          "*invalid*"
    test "a4371"          "*invalid*"
    test "a4371"          "*invalid*"
    test "96e3"           "*invalid*"
    test "0dc71"          "*invalid*"
    test "2a9f51"         "*invalid*"
    test "a43fb2"         "*invalid*"
    test "ab6e75"         "*invalid*"
    test "a5dcfa"         "*invalid*"
    test "ca97"           "*invalid*"
    test "6822dcb"        "*invalid*"
