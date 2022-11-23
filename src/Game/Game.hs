module Game.Game(
    startGame
) where

import Data.Aeson
import Data.Text
import qualified Data.ByteString.Lazy as Lazy

import Question.Question

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

startGame :: IO ()
startGame = do
  questions <- parseQuestions
  renderQuestion (Prelude.head questions)