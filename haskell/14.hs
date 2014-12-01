-- オフラインリアルタイムどう書く第14回の問題
-- 眠れるモンスターを狩る
-- http://qiita.com/Nabetani/items/0597bd3af481e5834ae1

-- 武器を一つづつ消費しながらモンスターを消します。
-- もしモンスターが消せたら新しい武器を手に入れます。
-- 武器が無くなったら、最初にいたモンスターの数から残っているモンスターの数を引いたものが答えです。

import Data.Char
import Data.List

monsterData, weaponData:: String
monsterData = "BDFHJL"
weaponData  = "acegika"

countHunt :: (String, String) -> Int
countHunt (initMonsters, initWeapons) = hunt initMonsters initWeapons
    where
        hunt :: String -> String -> Int
        hunt monsters []          = length initMonsters - length monsters
        hunt monsters (w:weapons) = hunt monsters' weapons'
            where
                Just index = elemIndex w weaponData
                target     = monsterData !! index
                newWeapon  = weaponData !! (index + 1)
                monsters'  = filter (/= target) monsters
                weapons'   = if target `notElem` monsters then weapons else newWeapon:weapons

parse :: String -> (String, String)
parse input = break isLower $ sort input

solve :: String -> String
solve = show . countHunt . parse

test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "gLDLBgBgHDaD"                           "6"
    test "DBcDLaLgDBH"                            "6"
    test "JJca"                                   "0"
    test "FJDLBH"                                 "0"
    test "HJBLFDg"                                "6"
    test "HBaDLFJ"                                "6"
    test "DJaHLB"                                 "2"
    test "gDLHJF"                                 "3"
    test "cJFgLHD"                                "5"
    test "FFBJaJJ"                                "1"
    test "FJeJFBJ"                                "2"
    test "iJFFJJB"                                "3"
    test "JBJiLFJF"                               "5"
    test "JDiFLFBJJ"                              "8"
    test "BDFDFFDFFLLFFJFDBFDFFFFDDFaDBFFB"       "28"
    test "DDFBFcBDFFFFFFLBFDFFBFLFDFDJDFDF"       "24"
    test "FDLBFDDBFFFeFFFFFDFBLDDFDDFBFFJF"       "16"
    test "FDBFFLFDFFDBBDFFBJDLFgDFFFDFFDFF"       "0"
    test "FDiFLDFFFFBDDJDDBFBFDFFFBFFDFLFF"       "31"
    test "FDFDJBLBLBFFDDFFFDFFFFFDDFBkFDFF"       "30"
    test "HBkFFFFHBLH"                            "3"
    test "FBHHFFFHLaB"                            "2"
    test "LFHFBBcHFHF"                            "0"
    test "LFBHFFeFHBH"                            "7"
    test "LgFHHHBFBFF"                            "3"
    test "FFiFHBHLBFH"                            "0"
    test "BFHHFFHBeFLk"                           "10"
    test "FHFaBBHFHLFg"                           "5"
    test "FFgacaFg"                               "0"
    test "JHDaDcBJiiHccBHDBDH"                    "9"
    test "FHJJLckFckFJHDFF"                       "12"
    test "DeDHJHDFHJBLHDLLDHJLBDD"                "22"
    test "gJLLLJgJgJLJL"                          "0"
    test "DaaaDDD"                                "0"
    test "HFeJFHiBiiBJeJBBFFB"                    "9"
    test "FJFFJDBHBHaLJBHJHDLHkLLLFFFgJgHJLHkJkB" "32"
    test "giFLBiBJLLJgHBFJigJJJBLHFLDLL"          "23"
    test "cgkLJcLJJJJgJc"                         "2"
    test "LDFHJHcFBDBLJBLFLcFJcDFBL"              "22"
    test "JJHHHkHJkHLJk"                          "1"
    test "kHHBBaBgHagHgaHBBB"                     "11"
    test "HDBFFDHHHDFLDcHHLFDcJD"                 "20"
    test "HFFFHeFFee"                             "7"
    test "gLLDHgDLgFL"                            "1"
    test "JJJBBaBBHBBHaLBHJ"                      "7"
    test "FBFBgJBDBDgF"                           "0"
    test "LLLLakakLakLL"                          "7"
    test "HeJHeJe"                                "0"
    test "LDFLBLLeBLDBBFFBLFBB"                   "4"
