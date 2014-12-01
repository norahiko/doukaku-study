-- オフラインリアルタイムどう書く第12回の問題
-- サイコロを転がす
-- http://qiita.com/Nabetani/items/f3cca410428f90333e28


type Dice = (Int, Int, Int)

roll :: Dice -> Char -> Dice
roll (a, b, c) 'N' = (7-b, a, c)
roll (a, b, c) 'S' = (b, 7-a, c)
roll (a, b, c) 'W' = (7-c, b, a)
roll (a, b, c) 'E' = (c, b, 7-a)
roll _ _           = error "invalid"

solve :: String -> String
solve input = concatMap (\(a, _, _) -> show a) $ scanl roll (1, 2, 3) input


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "NNESWWS"      "15635624"
    test "EEEE"         "13641"
    test "WWWW"         "14631"
    test "SSSS"         "12651"
    test "NNNN"         "15621"
    test "EENN"         "13651"
    test "WWNN"         "14651"
    test "SSNN"         "12621"
    test "NENNN"        "153641"
    test "NWNNN"        "154631"
    test "SWWWSNEEEN"   "12453635421"
    test "SENWSWSNSWE"  "123123656545"
    test "SSSWNNNE"     "126546315"
    test "SWNWSSSWWE"   "12415423646"
    test "ENNWWS"       "1354135"
    test "ESWNNW"       "1321365"
    test "NWSSE"        "154135"
    test "SWNWEWSEEN"   "12415154135"
    test "EWNWEEEEWN"   "13154532426"
    test "WNEWEWWWSNW"  "145151562421"
    test "NNEE"         "15631"
    test "EEEEWNWSW"    "1364145642"
    test "SENNWWES"     "123142321"
    test "SWWWSNSNESWW" "1245363635631"
    test "WESSENSE"     "141263231"
    test "SWNSSESESSS"  "124146231562"
    test "ENS"          "1353"
    test "WNN"          "1453"
    test "SSEENEEEN"    "1263124536"
    test "NWSNNNW"      "15414632"
    test "ESSSSSWW"     "132453215"
    test "ESE"          "1326"
    test "SNWNWWNSSSS"  "121456232453"
    test "SWEESEN"      "12423653"
    test "NEEWNSSWWW"   "15323631562"
    test "WSEW"         "14212"
    test "SWSNNNSNWE"   "12464131353"
    test "ENWEWSEEW"    "1351513545"
    test "WSEWN"        "142124"
    test "EWNEESEWE"    "1315321414"
    test "NESEEN"       "1531263"
    test "WSW"          "1426"
    test "ENEWE"        "135656"
