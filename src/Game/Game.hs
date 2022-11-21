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

startGame :: IO ()
startGame = do
  -- Get JSON data and decode it.
  d <- fmap eitherDecode getJSON :: IO (Either String [Question])
  
  case d of
    Left err -> putStrLn err
    Right questions -> mapM_ renderQuestion questions