-- オフラインリアルタイムどう書く第18回の参考問題
-- 山折り谷折り
-- http://qiita.com/Nabetani/items/373105e7fafd12f5e9fd 

-- 17回参考問題の解き方の応用（というか基本？）だったので、すぐに解法を思いつきました。
-- 紙を折るように解くのではなく、すでに折ってある紙を開くように解きます。

data Fold = M | V deriving Eq

instance Show Fold where
    show M = "m"
    show V = "V"

flipFolds :: [Fold] -> [Fold]
flipFolds folds = map (\f -> if f == M then V else M) (reverse folds)

openFolds :: Char -> [Fold] -> [Fold]
openFolds c folds = case c of
    'L' -> flipped ++ V : folds
    'J' -> folds   ++ V : flipped
    'Z' -> folds   ++ M : flipped ++ V : folds
    'U' -> flipped ++ V : folds   ++ V : flipped
    'S' -> folds   ++ V : flipped ++ M : folds
    where
        flipped = flipFolds folds

solve :: String -> String
solve input = concatMap show $ foldr openFolds [] input


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "JZ"     "mVVmV"
    test "J"      "V"
    test "L"      "V"
    test "Z"      "mV"
    test "U"      "VV"
    test "S"      "Vm"
    test "JL"     "VVm"
    test "JS"     "VmVVm"
    test "JU"     "VVVmm"
    test "LU"     "mmVVV"
    test "SL"     "VVmmV"
    test "SS"     "VmVVmmVm"
    test "SU"     "VVVmmmVV"
    test "SZ"     "mVVmVmmV"
    test "UL"     "mVVVm"
    test "UU"     "mmVVVVmm"
    test "UZ"     "mVVmVVmV"
    test "ZJ"     "VmmVV"
    test "ZS"     "VmmVmVVm"
    test "ZZ"     "mVmmVVmV"
    test "JJJ"    "VVmVVmm"
    test "JJZ"    "mVVmVVmVmmV"
    test "JSJ"    "VVmmVVmVVmm"
    test "JSS"    "VmVVmmVmVVmVVmmVm"
    test "JUS"    "VmVVmVVmVVmmVmmVm"
    test "JUU"    "mmVVVVmmVVVmmmmVV"
    test "JUZ"    "mVVmVVmVVmVmmVmmV"
    test "LJJ"    "VmmVVVm"
    test "LLS"    "VmmVmVVmVVm"
    test "LLU"    "mmmVVVmmVVV"
    test "LLZ"    "mVmmVVmVVmV"
    test "LSU"    "mmVVVmmmVVVVmmmVV"
    test "LSZ"    "mVVmVmmVVmVVmVmmV"
    test "LZL"    "mmVVmVVmmVV"
    test "LZS"    "VmmVmVVmVVmmVmVVm"
    test "LZU"    "mmmVVVmmVVVmmmVVV"
    test "SJL"    "VVmVVmmmVVm"
    test "SLU"    "mmVVVVmmmVVmmmVVV"
    test "SLZ"    "mVVmVVmVmmVmmVVmV"
    test "SSU"    "VVVmmmVVVmmVVVmmmmVVVmmmVV"
    test "SUJ"    "mVVVmVVmmmVmmVVVm"
    test "SUS"    "VmVVmVVmVVmmVmmVmmVmVVmVVm"
    test "SZZ"    "mVmmVVmVVmVmmVVmVmmVmmVVmV"
    test "UJJ"    "VmmVVVmVVmm"
    test "ULU"    "mmmVVVmmVVVVmmmVV"
    test "ULZ"    "mVmmVVmVVmVVmVmmV"
    test "UUU"    "VVmmmmVVVmmVVVVmmVVVmmmmVV"
    test "ZJU"    "VVVmmmVVmmmVVVVmm"
    test "ZLS"    "VmVVmmVmmVmVVmVVm"
    test "ZSJ"    "VVmmVmmVVmmVVVmmV"
    test "ZUJ"    "mVVVmmVmmmVVmVVVm"
    test "JJLJ"   "mVVVmmVVmVVmmmV"
    test "JLJJ"   "VmmVVVmVVmmmVVm"
    test "JLJL"   "VmmVVVmVVmmmVVm"
    test "LJJL"   "VVmmVmmVVVmVVmm"
    test "LLJJ"   "VmmmVVmVVmmVVVm"
    test "SZUS"   "VmVVmVVmmVmmVmmVmVVmVVmVVmVVmmVmmVmmVmVVmVVmVVmmVmmVmmVmVVmVVmmVmmVmmVmVVmVVmVVm"
    test "ULLS"   "VmmVmmVmVVmVVmmVmVVmVVmVVmmVmmVmVVm"
    test "JJJJZJ" "VmmVVVmmVVmVVmmVVmmmVVmVVmmVVVmmVVmmVmmVVmmmVVmVVmmVVVmmVVmVVmmVVmmmVVmmVmmVVVmmVVmmVmmVVmmmVVm"
    test "JULLLJ" "mmVmmVVmmmVVmVVVmmVmmVVVmmVVmVVVmmVmmVVmmmVVmVVVmmVmmVVVmmVVmVVmmmVmmVVmmmVVmVVmmmVmmVVVmmVVmVV"
    test "LJJJUL" "mVVVmVVmmmVVmVVVmmVmmmVmmVVVmVVmmmVmmVVVmmVmmmVVmVVVmVVmmmVVmVVVmmVmmmVVmVVVmVVmmmVmmVVVmmVmmmV"
    test "LJSJJL" "VVmVVmmVVVmmVmmmVVmVVmmmVVmmVmmVVVmVVmmmVVmmVmmVVVmVVmmVVVmmVmmmVVmVVmmVVVmmVmmVVVmVVmmmVVmmVmm"
    test "LZLLLJ" "mmVmmVVmmmVVmVVmmmVmmVVVmmVVmVVVmmVmmVVmmmVVmVVVmmVmmVVVmmVVmVVmmmVmmVVmmmVVmVVVmmVmmVVVmmVVmVV"
    test "SJJJJL" "VVmVVmmVVVmmVmmVVVmVVmmmVVmmVmmVVVmVVmmVVVmmVmmmVVmVVmmmVVmmVmmmVVmVVmmVVVmmVmmVVVmVVmmmVVmmVmm"
    test "ZLJLJL" "VmmVVVmmVmmmVVmVVmmVVVmVVmmmVVmmVmmVVVmmVmmmVVmmVmmVVVmVVmmmVVmVVmmVVVmmVmmmVVmVVmmVVVmVVmmmVVm"
