module Random.Random(
    randomIntInRange,
    randomPercentageChance
) where

import System.Random
import System.IO.Unsafe

randomIntInRange :: Int -> Int -> Int
randomIntInRange x y = unsafePerformIO (randomRIO (x, y))
-- unsafePerformIO (getStdRandom (randomR (x, y)))

randomPercentageChance :: Int -> Bool
randomPercentageChance chanceRate = (randomIntInRange 1 100) <= chanceRate
