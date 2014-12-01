-- オフラインリアルタイムどう書く第4回の問題
-- テトロミノ認識
-- http://nabetani.sakura.ne.jp/hena/ord4tetroid/

import Data.List.Split (splitOn)
import Data.List
import Data.Char
import Data.Tuple

type Cell = (Int, Int)

type Piece = [Cell]

sub :: Num a => (a, a) -> (a, a) -> (a, a)
(ax, ay) `sub` (bx, by) = (ax - bx, ay - by)

dist :: Num a => [(a, a)] -> [(a, a)]
dist (x:y:xs) = y `sub` x : dist (y:xs)
dist _        = []

parse :: String -> Piece
parse input = do
    [x, y] <- splitOn "," input
    return (digitToInt x, digitToInt y)

distL, distI, distT, distO, distS :: [(Int, Int)]
distL = dist $ sort $ parse "07,17,06,05"
distI = dist $ sort $ parse "24,22,25,23"
distT = dist $ sort $ parse "12,10,21,11"
distO = dist $ sort $ parse "68,57,58,67"
distS = dist $ sort $ parse "43,54,53,42"

transforms :: Piece -> [Piece]
transforms piece = do
    rotated <- take 4 (iterate rotate piece)
    ts      <- [id, transpose']
    return $ sort $ ts rotated

transpose' :: Piece -> Piece
transpose' = map swap

rotate :: Piece -> Piece
rotate = map (\(x, y) -> (9-y, x))

match :: [Piece] -> String
match [] = "-"
match (p:ps)
    | d == distL = "L"
    | d == distI = "I"
    | d == distT = "T"
    | d == distO = "O"
    | d == distS = "S"
    | otherwise   = match ps
    where d = dist p

solve :: String -> String
solve input = match (transforms $ parse input)

test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input
main :: IO ()
main = do
    test "55,55,55,55" "-"
    test "07,17,06,05" "L"
    test "21,41,31,40" "L"
    test "62,74,73,72" "L"
    test "84,94,74,75" "L"
    test "48,49,57,47" "L"
    test "69,89,79,68" "L"
    test "90,82,91,92" "L"
    test "13,23,03,24" "L"
    test "24,22,25,23" "I"
    test "51,41,21,31" "I"
    test "64,63,62,65" "I"
    test "49,69,59,79" "I"
    test "12,10,21,11" "T"
    test "89,99,79,88" "T"
    test "32,41,43,42" "T"
    test "27,16,36,26" "T"
    test "68,57,58,67" "O"
    test "72,62,61,71" "O"
    test "25,24,15,14" "O"
    test "43,54,53,42" "S"
    test "95,86,76,85" "S"
    test "72,73,84,83" "S"
    test "42,33,32,23" "S"
    test "66,57,67,58" "S"
    test "63,73,52,62" "S"
    test "76,68,77,67" "S"
    test "12,11,22,01" "S"
    test "05,26,06,25" "-"
    test "03,11,13,01" "-"
    test "11,20,00,21" "-"
    test "84,95,94,86" "-"
    test "36,56,45,35" "-"
    test "41,33,32,43" "-"
    test "75,94,84,95" "-"
    test "27,39,28,37" "-"
    test "45,34,54,35" "-"
    test "24,36,35,26" "-"
    test "27,27,27,27" "-"
    test "55,44,44,45" "-"
    test "70,73,71,71" "-"
    test "67,37,47,47" "-"
    test "43,45,41,42" "-"
    test "87,57,97,67" "-"
    test "49,45,46,48" "-"
    test "63,63,52,72" "-"
    test "84,86,84,95" "-"
    test "61,60,62,73" "-"
    test "59,79,69,48" "-"
    test "55,57,77,75" "-"
