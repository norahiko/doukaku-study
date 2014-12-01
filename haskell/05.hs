-- オフラインリアルタイムどう書く第5回の問題
-- 大貧民
-- http://nabetani.sakura.ne.jp/hena/ord5dahimi/

-- 場に出ているカードの枚数をNとします。
-- 手札のカードからN枚を抜き出して作れる組み合わせから、
-- 場に出ているカードの共通のランクより高いものを抜き出した組み合わせが答えです。

import Data.List (intercalate)
import Data.Maybe (mapMaybe)
import Data.List.Split (chunksOf, splitOn)

data Rank = R3 | R4 | R5 | R6 | R7 | R8 | R9 | RT | RJ | RQ | RK | RA | R2 | Joker deriving (Show, Read, Eq, Ord)

data Suit = C | D | H | S | Jo deriving (Show, Read, Eq, Ord)

data Card = Card { getSuit :: Suit, getRank :: Rank } deriving (Eq, Ord)

instance Show Card where
    show (Card Jo Joker)  = "Jo"
    show (Card suit rank) = show suit ++ tail (show rank)

combination :: [a] -> Int -> [[a]]
combination _ 0  = [[]]
combination [] _ = []
combination (x:xs) n = map (x:) (combination xs (n-1)) ++ combination xs n

rankEqual :: Rank -> Rank -> Bool
rankEqual x y = x == y || x == Joker || y == Joker

commonRank :: [Card] -> Maybe Rank
commonRank []     = error "invalid"
commonRank [x]    = Just $ getRank x
commonRank (x:xs) = do
    rank <- commonRank xs
    if rank `rankEqual` (getRank x)
        then Just $ min rank (getRank x)
        else Nothing

parseCards :: String -> [Card]
parseCards input = map toCard $ chunksOf 2 input
    where
        toCard "Jo"        = Card Jo Joker
        toCard [suit, num] = Card (read [suit]) (read ['R', num])
        toCard _           = error "invalid"

parse :: String -> ([Card], [Card])
parse input = (parseCards field, parseCards hand)
    where
        [field, hand] = splitOn "," input

judge :: Rank -> [Card] -> Maybe [Card]
judge fieldRank hand = do
    handRank <- commonRank hand
    if fieldRank < handRank
        then Just hand
        else Nothing

higherHands :: ([Card], [Card]) -> [[Card]]
higherHands (field, hand) = mapMaybe (\h -> judge fieldRank h) comb
    where
        comb           = combination hand fieldNum
        Just fieldRank = commonRank field
        fieldNum       = length field

printHands :: [[Card]] -> String
printHands []    = "-"
printHands hands = intercalate "," $ map (concatMap show) hands

solve :: String -> String
solve = printHands . higherHands . parse


-- テストは省略
main :: IO ()
main = do
    let inputs = ["DJ,",
                  "H7,HK",
                  "S3,D4D2",
                  "S9,C8H4",
                  "S6,S7STCK",
                  "H4,SAS8CKH6S4",
                  "ST,D6S8JoC7HQHAC2CK",
                  "SA,HAD6S8S6D3C4H2C5D4CKHQS7D5",
                  "S2,D8C9D6HQS7H4C6DTS5S6C7HAD4SQ",
                  "Jo,HAC8DJSJDTH2",
                  "S4Jo,CQS6C9DQH9S2D6S3",
                  "CTDT,S9C2D9D3JoC6DASJS4",
                  "H3D3,DQS2D6H9HAHTD7S6S7Jo",
                  "D5Jo,CQDAH8C6C9DQH7S2SJCKH5",
                  "C7H7,S7CTH8D5HACQS8JoD6SJS5H4",
                  "SAHA,S7SKCTS3H9DJHJH7S5H2DKDQS4",
                  "JoC8,H6D7C5S9CQH9STDTCAD9S5DAS2CT",
                  "HTST,SJHJDJCJJoS3D2",
                  "C7D7,S8D8JoCTDTD4CJ",
                  "DJSJ,DTDKDQHQJoC2",
                  "C3H3D3,CKH2DTD5H6S4CJS5C6H5S9CA",
                  "D8H8S8,CQHJCJJoHQ",
                  "H6D6S6,H8S8D8C8JoD2H2",
                  "JoD4H4,D3H3S3C3CADASAD2",
                  "DJHJSJ,SQDQJoHQCQC2CA",
                  "H3D3Jo,D4SKH6CTS8SAS2CQH4HAC5DADKD9",
                  "C3JoH3D3,S2S3H7HQCACTC2CKC6S7H5C7",
                  "H5C5S5D5,C7S6D6C3H7HAH6H4C6HQC9",
                  "H7S7C7D7,S5SAH5HAD5DAC5CA",
                  "D4H4S4C4,S6SAH6HAD6DAC6CAJo",
                  "DTCTSTHT,S3SQH3HQD3DQC3CQJo",
                  "JoS8D8H8,S9DTH9CTD9STC9CAC2"]

    mapM_ (putStrLn . solve) inputs
