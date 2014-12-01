-- オフラインリアルタイムどう書く第7回の問題
-- のんびり座りたい
-- http://nabetani.sakura.ne.jp/hena/ord7selectchair/

import Data.Char
import Data.List.Split

leave :: Char -> String -> String
leave _ []      = []
leave p (x:xs)
    | p == x    = '-' : xs
    | otherwise = x   : leave p xs

sit :: Char -> String -> String
sit p seat
    | p `elem` seat2 = seat2
    | p `elem` seat1 = seat1
    | otherwise      = seat0
    where
        seat2 = sit2 p seat
        seat1 = sit1 p seat
        seat0 = sit0 p seat

sit2 :: Char -> String -> String
sit2 p ('*':'-':'-':xs) = '*' : p : '-' : xs
sit2 p ('-':'-':'-':xs) = '-' : p : '-' : xs
sit2 p ('-':'-':"*")    = '-' : p : "*"
sit2 p (x:xs)           = x : sit2 p xs
sit2 _ []               = []

sit1 :: Char -> String -> String
sit1 p ('*':'-':xs) = '*' : p : xs
sit1 p ('-':'-':xs) = p : '-' : xs
sit1 p ('-':"*")    = p : "*"
sit1 p (x:xs)       = x : sit1 p xs
sit1 _ []           = []

sit0 :: Char -> String -> String
sit0 p ('-':xs)     = p : xs
sit0 p (x:xs)       = x : sit0 p xs
sit0 _ []           = []

parse :: String -> (String, String)
parse input = (seat, events)
    where
        [seatNum, events] = splitOn ":" input
        seat = '*' : (replicate (read seatNum) '-') ++ "*"

iterEvent :: (String, String) -> String
iterEvent (seat, events) = iter seat events
    where
        iter seat' []     = seat'
        iter seat' (e:es)
            | isLower e = iter (leave (toUpper e) seat') es
            | otherwise = iter (sit e seat') es

stripEdge :: String -> String
stripEdge = init . tail

solve :: String -> String
solve = stripEdge . iterEvent . parse

test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "6:NABEbBZn"        "-ZAB-E"
    test "1:A"               "A"
    test "1:Aa"              "-"
    test "2:AB"              "AB"
    test "2:AaB"             "B-"
    test "2:AZa"             "-Z"
    test "2:AZz"             "A-"
    test "3:ABC"             "ACB"
    test "3:ABCa"            "-CB"
    test "4:ABCD"            "ADBC"
    test "4:ABCbBD"          "ABDC"
    test "4:ABCDabcA"        "-D-A"
    test "5:NEXUS"           "NUESX"
    test "5:ZYQMyqY"         "ZM-Y-"
    test "5:ABCDbdXYc"       "AYX--"
    test "6:FUTSAL"          "FAULTS"
    test "6:ABCDEbcBC"       "AECB-D"
    test "7:FMTOWNS"         "FWMNTSO"
    test "7:ABCDEFGabcdfXYZ" "YE-X-GZ"
    test "10:ABCDEFGHIJ"     "AGBHCIDJEF"
