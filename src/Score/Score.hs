module Score.Score(
    updateScore
) where

updateScore :: Char -> Float -> Float
updateScore operation currentScore
    | operation == 'w' && currentScore == 0 = 1000
    | operation == 'w' && currentScore > 500000 = 1000000
    | operation == 'w' = currentScore * 2
    | operation == 'l' = currentScore / 2
    | otherwise = currentScore
