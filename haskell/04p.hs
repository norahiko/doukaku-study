-- オフラインリアルタイムどう書く第4回の参考問題
-- フカシギの通行止め
-- http://qiita.com/Nabetani/items/9c514267214d3917edf2

import Data.Char
import Data.List.Split (splitOn)
import qualified Data.Set as Set

width, height :: Int
width  = 5
height = 5

goal :: (Int, Int)
goal   = (width-1, height-1)

type Vertex  = (Int, Int)
type Blocked = Set.Set (Vertex, Vertex)
type Visited = Set.Set Vertex

c2v :: Char -> Vertex
c2v ch = divMod (ord ch - ord 'a') width

makeBlocked :: String -> Blocked
makeBlocked input = Set.fromList vertexes
    where
        vertexes = do
            [a, b] <- splitOn " " input
            [(c2v a, c2v b), (c2v b, c2v a)]

walk :: Blocked -> Visited -> Vertex -> Int
walk blocked visited vertex@(x, y)
    | Set.member vertex visited = 0
    | vertex == goal            = 1
    | otherwise                 = sum $ map (walk blocked visited') nexts
    where
        nexts                  = filter validate [(x+1, y), (x-1, y), (x, y+1), (x, y-1)]
        visited'               = Set.insert vertex visited
        validate next@(nx, ny) = 0 <= nx && nx < width && 0 <= ny && ny < height && not (hasBlocked next)
        hasBlocked next        = Set.member (vertex, next) blocked

solve :: String -> String
solve input = show $ walk (makeBlocked input) Set.empty (0, 0)


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "" "8512"
    test "af" "4256"
    test "xy" "4256"
    test "pq qr rs st di in ns sx" "184"
    test "af pq qr rs st di in ns sx" "92"
    test "bg ch di ij no st" "185"
    test "bc af ch di no kp mr ns ot pu rs" "16"
    test "ab af" "0"
    test "ty xy" "0"
    test "bg ch ej gh lm lq mr ot rs sx" "11"
    test "ty ch hi mn kp mr rs sx" "18"
    test "xy ch hi mn kp mr rs sx" "32"
    test "ch hi mn kp mr rs sx" "50"
    test "ab cd uv wx" "621"
    test "gh mn st lq qr" "685"
    test "fg gl lm mr rs" "171"
