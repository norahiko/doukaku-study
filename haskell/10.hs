-- オフラインリアルタイムどう書く第10回の問題
-- ハニカム歩き
-- http://qiita.com/Nabetani/items/55641767510c2f9f235f

-- ゲームでよく見る六角形のマップの作り方をググってみると
-- 軸が傾いたXY座標として表現できることが分かったので、
-- 素直に、レールの問題と同じように解きます。

import qualified Data.Map as Map

type Pos = (Int, Int)

mapData :: [String]
mapData = ["!!!TUVW",
           "!!kHIJX",
           "!jSBCKY",
           "iRGADLZ",
           "hQFEMa!",
           "gPONb!!",
           "fedc!!!"]

hexMap :: Map.Map Pos Char
hexMap = Map.fromList [((x, y), mapData !! y !! x) | x <- [0..6], y <- [0..6]]

hexDelta :: Char -> Pos
hexDelta n = case n of
    '0' -> (0, -1)
    '1' -> (1, -1)
    '2' -> (1, 0)
    '3' -> (0, 1)
    '4' -> (-1, 1)
    _   -> (-1, 0)

walk :: Char -> Pos -> String -> String
walk current _ []             = [current]
walk current pos@(x, y) (c:input) = case Map.lookup npos hexMap of
    Just '!'  -> current : walk '!'  pos input
    Just next -> current : walk next npos   input
    Nothing   -> current : walk '!'  pos input
    where
        (dx, dy) = hexDelta c
        npos     = (x + dx, y + dy)

solve :: String -> String
solve input = walk 'A' (3, 3) input


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "135004"      "ACDABHS"
    test "1"           "AC"
    test "33333120"    "AENc!!b!M"
    test "0"           "AB"
    test "2"           "AD"
    test "3"           "AE"
    test "4"           "AF"
    test "5"           "AG"
    test "4532120"     "AFQPOEMD"
    test "051455"      "ABSHSj!"
    test "23334551"    "ADMb!cdeO"
    test "22033251"    "ADLKLa!ML"
    test "50511302122" "AGSjkTHTU!VW"
    test "000051"      "ABHT!!!"
    test "1310105"     "ACDKJW!V"
    test "50002103140" "AGSk!HU!IVIU"
    test "3112045"     "AEDKYXKC"
    test "02021245535" "ABCIJW!JIHBS"
    test "014204"      "ABIBCIB"
    test "255230"      "ADAGAEA"
    test "443501"      "AFPefgQ"
    test "022321"      "ABCKLZ!"
    test "554452"      "AGRh!!Q"
    test "051024"      "ABSHTUH"
    test "524002"      "AGAFGSB"
    test "54002441132" "AGQRjSRhRSGA"
    test "11010554312" "ACJV!!UTkSHI"
    test "23405300554" "ADMNEFOFGRi!"
    test "555353201"   "AGRih!gPQG"
    test "22424105"    "ADLMabaLD"
    test "11340202125" "ACJKDCKJX!!J"
    test "4524451"     "AFQFPf!P"
    test "44434234050" "AFPf!!e!!Pgh"
    test "00554040132" "ABHk!j!i!jRG"
    test "3440403"     "AEOePfgf"
    test "111130"      "ACJW!XW"
    test "21133343125" "ADKXYZ!a!Z!L"
    test "353511"      "AEFOPFA"
    test "22204115220" "ADLZYLY!KY!X"
    test "03013541"    "ABABICBGB"
    test "101344"      "ACIVJCA"
    test "2432541"     "ADENbNdN"
    test "45332242015" "AFQPedc!!NME"
    test "215453"      "ADKCAGF"
    test "45540523454" "AFQh!i!RQg!!"
    test "42434302545" "AFEOd!!ONOef"
