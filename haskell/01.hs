-- 第一回 オフラインリアルタイムどう書くの問題
-- Tick-Tack-Toe
-- http://nabetani.sakura.ne.jp/hena/1/


type Player = Char

data Game = Result String
          | Move Player String
          deriving (Show, Eq)

nextPlayer :: Player -> Player
nextPlayer 'x' = 'o'
nextPlayer _   = 'x'

step2 :: [a] -> [a]
step2 (x:_:xs) = x : step2 xs
step2 xs       = xs

wonPattern :: [String]
wonPattern = ["123", "456", "789", "147", "258", "369", "159", "357"]

judge :: String -> Bool
judge moves = any (all (`elem` pmoves)) wonPattern
    where
        pmoves = step2 moves

iterGame :: Game -> Char -> Game
iterGame (Result msg) _ = Result msg
iterGame (Move player moves) m
    | length moves == 9 = Result "Draw game."
    | m `elem` moves    = Result $ "Foul : " ++ nextPlayer player : " won."
    | otherwise         = case judge (m:moves) of
        True  -> Result $ player : " won."
        False -> Move (nextPlayer player) (m:moves)

solve :: String -> String
solve input = case foldl iterGame (Move 'o' []) input of
    (Result msg) -> msg
    (Move _ _)   -> "Draw game."

test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "965715" "o won."
    test "79538246" "x won."
    test "35497162193" "x won."
    test "61978543" "x won."
    test "254961323121" "x won."
    test "6134278187" "x won."
    test "4319581" "Foul : x won."
    test "9625663381" "Foul : x won."
    test "7975662" "Foul : x won."
    test "2368799597" "Foul : x won."
    test "18652368566" "Foul : x won."
    test "38745796" "o won."
    test "371929" "o won."
    test "758698769" "o won."
    test "42683953" "o won."
    test "618843927" "Foul : o won."
    test "36535224" "Foul : o won."
    test "882973" "Foul : o won."
    test "653675681" "Foul : o won."
    test "9729934662" "Foul : o won."
    test "972651483927" "Draw game."
    test "5439126787" "Draw game."
    test "142583697" "Draw game."
    test "42198637563" "Draw game."
    test "657391482" "Draw game."
