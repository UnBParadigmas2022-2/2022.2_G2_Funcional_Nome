module Choice.Choice(
    generateChoices,
    Choice
) where

data Choice = Choice{
    value  :: String,
    estate :: Bool,
    correct :: Bool
} deriving Show

generateChoice :: String -> Choice
generateChoice n = do
    Choice {value = n, estate=False, correct=False}

generateChoices :: [String] -> [Choice] -> [Choice]
generateChoices [] baralho = baralho
generateChoices (x : xs) baralho = generateChoices xs baralho++[generateChoice x]