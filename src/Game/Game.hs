module Game.Game(
    startGame
    ) where

import Choice.Choice
import Question.Question

startGame :: IO ()
startGame = do
    let choices = generateChoices ["choice2", "choice1"] []
    let question = generateQuestion choices
    print question