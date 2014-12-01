-- 第19回オフラインリアルタイムどう書くの問題
-- 不良セクタの隣
-- http://nabetani.sakura.ne.jp/hena/ord19nebasec/

import Data.List
import Data.List.Split
import Text.Printf
import Control.Monad

type Track = Int
type Sector = Int
type Address = (Track, Sector)

solve :: String -> String
solve = output . check . parse

parse :: String -> [Address]
parse xs = [(n `div` 100, n `mod` 100) | n <- map read $ splitOn "," xs]

check :: [Address] -> [Address]
check bads = [adr | (adr, count) <- freq, 1 < count]
    where
        near = sort $ concat $ map nearSectors bads
        near' = [n | n <- near, not $ elem n bads]
        freq = [(head n, length n) | n <- group near']

output :: [Address] -> String
output []      = "none"
output address = intercalate "," $ map (\(t, s) -> printf "%d%02d" t s) address


nearSectors :: Address -> [Address]
nearSectors sec@(track, sector) = (track, prev) : (track, next) : sectors
    where
        sectors = nearTrackSectors sec (track - 1) ++ nearTrackSectors sec (track + 1)
        next    = (sector + 1) `mod` lim
        prev    = (sector + lim - 1) `mod` lim
        lim     = track * 8

nearTrackSectors :: Address -> Track -> [Address]
nearTrackSectors (at, as) bt = do
    guard (0 < bt && bt < 5)
    bs <- [0..bt*8-1]

    let ad = 1.0 / 8.0 / (fromIntegral at) :: Float
        bd = 1.0 / 8.0 / (fromIntegral bt) :: Float
        aa = fromIntegral as * ad
        ba = fromIntegral bs * bd
        dba = abs (ba - aa)
        diff = if dba < 0.5 then dba else 1 - dba

    guard (diff < (bd + ad) / 2)
    return (bt, bs)


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "400,401,302"                                 "300,301,402"
    test "105,100,306,414"                             "none"
    test "100"                                         "none"
    test "211"                                         "none"
    test "317"                                         "none"
    test "414"                                         "none"
    test "100,106"                                     "107"
    test "205,203"                                     "102,204"
    test "303,305"                                     "304"
    test "407,409"                                     "306,408"
    test "104,103"                                     "207"
    test "204,203"                                     "102,305"
    test "313,314"                                     "209,418"
    test "419,418"                                     "314"
    test "100,102,101"                                 "201,203"
    test "103,206,309"                                 "205,207,308,310"
    test "414,310,309"                                 "206,311,413"
    test "104,102,206,307,102,202"                     "101,103,203,204,205,207,308"
    test "104,206,308,409,407"                         "103,205,207,306,307,309,408,410"
    test "313,406,213,301,409,422,412,102,428"         "none"
    test "101,300,210,308,423,321,403,408,415"         "none"
    test "304,316,307,207,427,402,107,431,412,418,424" "none"
    test "205,408,210,215,425,302,311,400,428,412"     "none"
    test "200,311,306,412,403,318,427,105,420"         "none"
    test "105,305,407,408,309,208,427"                 "104,209,306,406"
    test "311,304,322,404,429,305,316"                 "203,303,321,405,406,430"
    test "210,401,316,425,101"                         "211,315"
    test "414,403,404,416,428,421"                     "303,415"
    test "207,300,103,211,428"                         "104,206"
    test "322,314,310"                                 "none"
    test "427,200,215"                                 "100,323"
    test "311,402,424,307,318,430,323,305,201"         "200,204,301,302,306,322,423,425,431"
    test "425,430,408"                                 "none"
    test "202,320,209,426"                             "319,427"
    test "430,209,302,310,304,431,320"                 "202,303,323"
    test "208,206,406,424,213,312"                     "207,311,313"
    test "420,302,313,413,317,402"                     "301,403"
    test "319,306,309,418,204,411"                     "305,307,308,412"
    test "400,308,105,430,203,428,209"                 "104,210,429,431"
    test "200,305,214"                                 "215"
    test "214,408,410,407,317,422"                     "306,316,409,423"
