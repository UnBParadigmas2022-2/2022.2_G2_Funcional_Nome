module Game.Game(
    startGame
) where

import Data.Aeson
import qualified Data.ByteString.Lazy as Lazy
import Network.Wreq
import GHC.Generics
import Control.Lens

import Question.Question
import Score.Score
import View.View


getQuestion :: IO [Question]
getQuestion = do
    response <- asJSON =<< get "https://the-trivia-api.com/api/questions?limit=15"
    pure (response ^. responseBody)


startGame :: IO()
startGame = do
  questions <- getQuestion
  gameLoop questions 0

gameLoop :: [Question] -> Float -> IO()
gameLoop questions currentScore = do
  showScoreMenu currentScore
  let actualQuestion = (Prelude.head questions)
  renderQuestion actualQuestion
  userAnswer <- getLine

  if ((checkUserAnswer userAnswer (getCorrectAnswer actualQuestion)) == 0)
    then do { printLines 100
            ; showLoserScreen
            ; showFinalScore (updateScore 'l' currentScore)}
  else do
    showRightAnswerMessage
    if (Prelude.null (Prelude.tail questions) == True || currentScore == 512000)
      then do { printLines 100
              ; showWinnerScreen
              ; showFinalScore (updateScore 'w' currentScore)}
    else do
      printLines 100
      showNextQuestionMessage
      gameLoop (Prelude.tail questions) (updateScore 'w' currentScore)
