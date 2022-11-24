module Game.Game(
    startGame
) where

import Data.Aeson
import qualified Data.ByteString.Lazy as Lazy

import Question.Question
import Score.Score
import View.View

jsonFile :: FilePath
jsonFile = "data/questions.json"

getJSON :: IO Lazy.ByteString
getJSON = Lazy.readFile jsonFile

parseQuestions :: IO [Question]
parseQuestions = do
    -- Get JSON data and decode it.
  d <- fmap eitherDecode getJSON :: IO (Either String [Question])

  case d of
    Left err -> return []
    Right questions -> return questions

startGame :: IO()
startGame = do
  questions <- parseQuestions
  gameLoop questions 0

gameLoop :: [Question] -> Float -> IO()
gameLoop questions currentScore = do
  showScoreMenu currentScore
  let actualQuestion = (Prelude.head questions)
  renderQuestion actualQuestion
  userAnswer <- getLine

  if ((checkUserAnswer userAnswer (getCorrectAnswer (getChoices actualQuestion))) == 0)
    then do { printLines 100
            ; showLoserScreen
            ; showFinalScore (updateScore 'l' currentScore)}
  else do
    showRightAnswerMessage
    if (Prelude.null (Prelude.tail questions) == True)
      then do { printLines 100
              ; showWinnerScreen
              ; showFinalScore (updateScore 'w' currentScore)}
    else do
      printLines 100
      showNextQuestionMessage
      gameLoop (Prelude.tail questions) (updateScore 'w' currentScore)
