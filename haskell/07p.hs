-- オフラインリアルタイムどう書く第7回の参考問題
-- XY-Sort
-- http://nabetani.sakura.ne.jp/hena/ord7xysort/

-- Haskellに標準で用意されているソート関数とtranspose(転置)関数を使って解きます。


import Data.List
import Data.Char

initMatrix :: [String]
initMatrix = [
    "414213",
    "732050",
    "236067",
    "645751",
    "316624",
    "605551"
    ]

sortY, sortX :: Int -> [String] -> [String]
sortY n mat = sortBy (\x y -> compare (x !! n) (y !! n)) mat
sortX n mat = transpose . (sortY n) . transpose $ mat

sortXY :: String -> [String] -> [String]
sortXY [] mat = mat
sortXY (x:xs) mat
    | isUpper x = sortXY xs $ sortX (ord x - ord 'A') mat
    | otherwise = sortXY xs $ sortY (ord x - ord 'u') mat

solve :: String -> String
solve input = head $ sortXY input initMatrix


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "AvEx"      "305027"
    test "A"         "112344"
    test "C"         "241413"
    test "F"         "134214"
    test "u"         "236067"
    test "w"         "732050"
    test "y"         "414213"
    test "yx"        "732050"
    test "ux"        "236067"
    test "EF"        "131424"
    test "DF"        "134124"
    test "Au"        "055165"
    test "uA"        "023667"
    test "By"        "234114"
    test "yB"        "114342"
    test "yBy"       "357020"
    test "yByB"      "350072"
    test "AuBvCw"    "131244"
    test "FAuFBvFCw" "300527"
    test "AuBv"      "112344"
    test "CwDx"      "515056"
    test "FzyE"      "324114"
    test "uAwDyB"    "114324"
    test "zExCvF"    "073520"
    test "uFxEv"     "002357"
    test "DyCwB"     "076362"
