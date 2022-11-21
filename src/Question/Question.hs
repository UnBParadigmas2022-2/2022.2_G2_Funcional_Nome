module Question.Question(
    Question
) where

import Data.Aeson
import Data.Text
import GHC.Generics

import Choice.Choice

data Question = Question{
    description :: Text,
    choices  :: [Choice]
} deriving (Show, Generic)

instance FromJSON Question
instance ToJSON Question
