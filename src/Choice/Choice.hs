module Choice.Choice(
    generateChoices,
    Choice
) where

data Choice = Choice{
    value  :: String,
    state :: Bool,
    correct :: Bool
} deriving Show

generateChoice :: String -> Choice
generateChoice n = do
    Choice {value = n, state=False, correct=False}

generateChoices :: [String] -> [Choice] -> [Choice]
generateChoices [] baralho = baralho
generateChoices (x : xs) baralho = generateChoices xs baralho++[generateChoice x]