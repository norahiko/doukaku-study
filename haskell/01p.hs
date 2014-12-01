-- 第一回 オフラインリアルタイムどう書くの参考問題
-- ポーカー
-- http://qiita.com/Nabetani/items/cbc3af152ee3f50a822f

-- ランクが等しいカードの数をそれぞれ数えてソートすれば、役が一意に決まります。


import Data.List
import Text.Regex.Posix

count :: Eq a => [a] -> a -> Int
count xs x = length $ filter (== x) xs

hand :: [Int] -> String
hand counts = case sort counts of
    [1, 4, 4, 4, 4] -> "4K"
    [2, 2, 3, 3, 3] -> "FH"
    [1, 1, 3, 3, 3] -> "3K"
    [1, 2, 2, 2, 2] -> "2P"
    [1, 1, 1, 2, 2] -> "1P"
    _               -> "--"

solve :: String -> String
solve cards = hand counts
    where
        counts = map (count rank) rank
        rank   = getAllTextMatches $ cards =~ "[0-9AJQK]+" :: [String]

test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input 

main :: IO ()
main = do
    test "S1S2S3S4S5" "--"
    test "S1D1S2S3S4" "1P"
    test "S1D1S2D2S3" "2P"
    test "S1D1H1S2S3" "3K"
    test "S1D1H1S2D2" "FH"
    test "S1D1H1C1S2" "4K"
