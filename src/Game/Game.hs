module Game.Game(
    startGame
) where

import Data.Aeson
import Data.Text
import qualified Data.ByteString.Lazy as Lazy
import Network.Wreq
import GHC.Generics
import Control.Lens

import Question.Question

-- jsonFile :: FilePath
-- jsonFile = "data/questions.json"

-- getJSON :: IO Lazy.ByteString
-- getJSON = Lazy.readFile jsonFile

-- parseQuestions :: IO [Question]
-- parseQuestions = do 
--     -- Get JSON data and decode it.
--   d <- fmap eitherDecode getJSON :: IO (Either String [Question])
  
--   case d of
--     Left err -> return []
--     Right questions -> return questions

getQuestion :: IO [Question]
getQuestion = do
    response <- asJSON =<< get "https://the-trivia-api.com/api/questions?limit=15"
    pure (response ^. responseBody)


startGame :: IO()
startGame = do
  questions <- getQuestion
  gameLoop questions

gameLoop :: [Question] -> IO()
gameLoop questions = do
  let actualQuestion = (Prelude.head questions)
  renderQuestion actualQuestion
  userAnswer <- getLine
  if ((checkUserAnswer userAnswer (getCorrectAnswer actualQuestion)) == 0)
    then putStrLn "Errou!"
  else do
    putStrLn "Acertou!"
    putStrLn "Próxima questão"
    if (Prelude.null (Prelude.tail questions) == True)
      then putStrLn "Parabens! Acertou todas as questões"
    else do
      gameLoop (Prelude.tail questions)