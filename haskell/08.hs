-- オフラインリアルタイムどう書く第8回の問題
-- ビットボンバーマン
-- http://qiita.com/Nabetani/items/709d61dff282cff7a890


import Data.Char
import Data.Bits
import Data.List
import Data.List.Split
import qualified Data.Set as Set


outOfLine :: Int -> Int -> Bool
outOfLine x d = if abs d == 1 then
                    if d < 0 then x `mod` 6 == 0 else (x + 1) `mod` 6 == 0
                else
                    if d < 0 then x + d < 0 else 30 <= x + d

flame :: Set.Set Int -> Int -> Int -> Set.Set Int
flame walls delta fire
    | fire `Set.member` walls = Set.empty
    | outOfLine fire delta    = Set.singleton fire
    | otherwise               = Set.insert fire (flame walls delta (fire + delta))

hexToBools :: Char -> [Bool]
hexToBools hex = map (testBit (digitToInt hex)) [3, 2, 1, 0]

indexes :: String -> [Int]
indexes hexes = elemIndices True $ concatMap hexToBools hexes

showFires :: Set.Set Int -> String
showFires xs = map (intToDigit . \[a,b,c,d] -> a*8 + b*4 + c*2 + d) bin4
    where
        bin  = map (\n -> if n `Set.member` xs then 1 else 0) [0..31]
        bin4 = chunksOf 4 bin

solve :: String -> String
solve input = showFires fires
    where
        [walls, bombs] = map indexes (splitOn "/" input)
        walls'         = Set.fromList walls
        deltas         = [1, -1, 6, -6]
        fires          = Set.unions [flame walls' delta bomb | delta <- deltas, bomb <- bombs]


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "802b1200/01400c20" "53c40cfc"
    test "28301068/84080504" "d64fef94"
    test "100a4010/80010004" "e241850c"
    test "81020400/000000fc" "0e3cfbfc"
    test "80225020/7e082080" "7fdd24d0"
    test "01201200/40102008" "fe1861fc"
    test "00201000/01000200" "43c48f08"
    test "00891220/81020408" "ff060c1c"
    test "410033c0/0c300000" "3cf0c000"
    test "00000000/01400a00" "7bf7bf78"
    test "00000000/20000a00" "fca2bf28"
    test "00000000/00000000" "00000000"
    test "00cafe00/00000000" "00000000"
    test "aaabaaaa/50000000" "51441040"
    test "a95a95a8/56a56a54" "56a56a54"
    test "104fc820/80201010" "ea30345c"
    test "4a940214/05000008" "05000008"
    test "00908000/05000200" "ff043f48"
    test "00c48c00/fe1861fc" "ff3873fc"
    test "00000004/81020400" "fffffff0"
    test "111028b0/40021100" "e08fd744"
    test "6808490c/01959000" "17f7b650"
    test "30821004/81014040" "c75de5f8"
    test "0004c810/10003100" "fe4937c4"
    test "12022020/88200000" "edf08208"
    test "2aa92098/01160000" "45165964"
    test "00242940/10010004" "fc43c43c"
    test "483c2120/11004c00" "33c3de10"
    test "10140140/44004a04" "eda3fe3c"
    test "0c901d38/72602200" "f36da280"
