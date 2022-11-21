module Question.Question(
    renderQuestion,
    Question
) where

import Data.Aeson
import Data.Text
import GHC.Generics

import Choice.Choice

data Question = Question{
    description :: String,
    choices  :: [Choice]
} deriving (Show, Generic)

instance FromJSON Question
instance ToJSON Question

renderQuestion :: Question -> IO ()
renderQuestion question = do
    putStrLn (description question) 
    mapM_ renderChoice (choices question)