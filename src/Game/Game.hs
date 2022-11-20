module Game.Game(
    startGame
    ) where

import Choice.Choice

startGame :: IO ()
startGame = do
    let choices = generateChoices ["choice2", "choice1"] []
    print choices