-- オフラインリアルタイムどう書く第14回の参考問題
-- 円周上のCrossing
-- http://qiita.com/Nabetani/items/66806c9dc14a96f2fd42

-- 直線の始点と終点の間に、もう一方の直線の端点があればその直線同士は交差していることが分かります。
-- 重複して交点を数えないように組み合わせを使います。


type Line = (Int, Int)

combination :: [a] -> Int -> [[a]]
combination _ 0      = [[]]
combination [] _     = []
combination (x:xs) n = map (x:) (combination xs (n-1)) ++ combination xs n

isCross :: [Line] -> Bool
isCross [(a, b), (x, y)] = (x < a && a < y && (b < x || y < b)) ||
                           (x < b && b < y && (a < x || y < a))

solve :: String -> String
solve input = show $ result
    where
        input' = zip input [0..]
        lines  = [(i, j) | [(x, i), (y, j)] <- combination input' 2, x == y]
        result = length $ filter isCross $ combination lines 2


test :: String -> String -> IO ()
test input expected
    | result == expected = return ()
    | otherwise          = error $ show input ++ " -- expected " ++ show expected ++ " but " ++ show result
    where
        result = solve input

main :: IO ()
main = do
    test "aabbca1bcb"       "14"
    test "111ZZZ"           "0"
    test "v"                "0"
    test "ww"               "0"
    test "xxx"              "0"
    test "yyyy"             "1"
    test "zzzzz"            "5"
    test "abcdef"           "0"
    test "abcaef"           "0"
    test "abbaee"           "0"
    test "abcacb"           "2"
    test "abcabc"           "3"
    test "abcdabcd"         "6"
    test "abcadeabcade"     "23"
    test "abcdeedcba"       "0"
    test "abcdeaedcba"      "8"
    test "abcdeaedcbad"     "16"
    test "QQQQXXXX"         "2"
    test "QwQQmQXmXXwX"     "14"
    test "111222333"        "0"
    test "aaAAaA"           "4"
    test "121232313"        "12"
    test "1ab1b"            "1"
    test "abcdefbadcfe"     "12"
    test "abxcdefbadcfex"   "14"
    test "dtnwtkt"          "0"
    test "mvubvpp"          "0"
    test "moggscd"          "0"
    test "kzkjzpkw"         "2"
    test "fbifybre"         "1"
    test "rrrfjryki"        "1"
    test "wrbbdwsdwtx"      "2"
    test "vvucugvxbvgx"     "9"
    test "ojkjzyasjwbfjj"   "5"
    test "ggffyuxnkyypifff" "5"

    test "vcgtcqlwrepwvkkogl"                                                         "4"
    test "xeqtmmgppwcjpcisogxbs"                                                      "4"
    test "lukltpeucrqfvcupnpxwmoj"                                                    "6"
    test "zpzswlkkoqwwndwpfdpkhtzgtn"                                                 "31"
    test "bkfeflagfvluelududqjcvfyvytfw"                                              "45"
    test "rvqbhfmcjjqlpqzulzerxgyowiwrfkmhw"                                          "26"
    test "qyxvpdtoeexbqsethwjwmqszcxxjnsdoeaet"                                       "144"
    test "rjmsgmswhcolmpbhmpncziymydyalrcnevsrespj"                                   "133"
    test "oxetnyjzjbysnwktfwzndlejfndsqeetsnjvsicyjehd"                               "395"
    test "wzvddnddzogywcqxbyvagbzmsmtcmrrlbnebmvhaemjouaqim"                          "219"
    test "karhphxcxqgsyorhusbumbqzocuzvnwzwcpxgsksrviihxrgsrhji"                      "461"
    test "oxgbononhqdxzmkysgijwvxljpaazmgkurkpffeuwywwuyxhyfkicgyzyc"                 "441"
    test "sdgsrddwsrwqthhdvhrjhgtxwgurgyiygtktgtughtogzaqmcafkljgpniddsvb"            "1077"
    test "qemhecchkgzhxmdcsltwhpoyhkapckkkzosmklcvzkiiucrvzzznmhjfcdumuflavxik"       "1711"
    test "ffqmsirwpxrzfkbvmmfeptkbhnrvfcywthkwkbycmayhhkgvuyecbwwofwthlmzruphrcujwhr" "2440"
