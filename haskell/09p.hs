-- オフラインリアルタイムどう書く第9回の参考問題
-- 数を作る
-- http://nabetani.sakura.ne.jp/hena/ord9nummake/

-- 順列を作るときに6か9の数字を見つけると、もう一方の数字も含んだ順列を作ります。

import Data.List

select69 :: String -> [(Char, String)]
select69 []    = []
select69 ('6':xs) = ('6', xs) : ('9', xs) : [(y, '6':ys) | (y, ys) <- select69 xs]
select69 ('9':xs) = ('6', xs) : ('9', xs) : [(y, '9':ys) | (y, ys) <- select69 xs]
select69 (x:xs) = (x, xs) : [(y, x:ys) | (y, ys) <- select69 xs]

perms69 :: Int -> String -> [String]
perms69 0 _  = [[]]
perms69 n xs = [x:zs | (x, ys) <- select69 xs, zs <- perms69 (n - 1) ys]

solve :: String -> String
solve input = if length perm < num then "-" else perm !! (num - 1)
    where
        [(num, ':':cards)] = reads input
        perm               = nub $ sort $ filter ((/= '0') . head) $ perms69 4 cards


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "13:01167"  "1109"
    test "1:1234"    "1234"
    test "2:1234"    "1243"
    test "7:1234"    "2134"
    test "24:1234"   "4321"
    test "25:1234"   "-"
    test "2:1116"    "1119"
    test "2:0116"    "1019"
    test "3:6666"    "6696"
    test "16:6666"   "9999"
    test "10:01267"  "1097"
    test "14:111167" "1671"
    test "1:1111"    "1111"
    test "2:1111"    "-"
    test "1:666633"  "3366"
    test "72:666611" "9999"
    test "73:666622" "-"
    test "1:666600"  "6006"
    test "52:666600" "9999"
    test "53:666600" "-"
    test "25:06688"  "8086"
    test "93:02566"  "6502"
    test "11:06688"  "6809"
    test "169:01268" "9801"
    test "174:01268" "9821"
    test "66:012288" "8201"
