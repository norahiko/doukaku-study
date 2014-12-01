-- オフラインリアルタイムどう書く第5回の参考問題
-- Rails on Tiles
-- http://nabetani.sakura.ne.jp/hena/ord5railsontiles/

import Data.Char

type Vector = (Int, Int)

vecToChar :: Vector -> Char
vecToChar (x, y) = chr (x + y * 3 + ord 'A')

move :: String -> Vector -> Vector -> String
move tiles (x, y) (vx, vy) = vecToChar (x, y) : next
    where
        next       = if canMove then move tiles (x', y') (vx', vy') else ""
        canMove    = 0 <= x' && x' < 3 && 0 <= y' && y' < 3
        (x', y')   = (x + vx', y + vy')
        (vx', vy') = case tiles !! (x + y*3) of
            '0'       -> (vx, vy)
            '1'       -> (vy, vx)
            _         -> (-vy, -vx)

solve :: String -> String
solve input = move input (1, 0) (0, 1)


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "101221102" "BEDGHIFEH"
    test "000000000" "BEH"
    test "111111111" "BCF"
    test "222222222" "BAD"
    test "000211112" "BEFIHEDGH"
    test "221011102" "BADGHIFEBCF"
    test "201100112" "BEHIFCBADEF"
    test "000111222" "BEFIH"
    test "012012012" "BC"
    test "201120111" "BEDABCFI"
    test "220111122" "BADEHGD"
    test "221011022" "BADG"
    test "111000112" "BCFIHEBA"
    test "001211001" "BEFI"
    test "111222012" "BCFEHIF"
    test "220111211" "BADEHI"
    test "211212212" "BCFEBAD"
    test "002112210" "BEFC"
    test "001010221" "BEF"
    test "100211002" "BEFIHG"
    test "201212121" "BEFCBAD"
