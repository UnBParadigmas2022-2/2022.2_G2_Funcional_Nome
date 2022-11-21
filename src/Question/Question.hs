module Question.Question(
    generateQuestion,
    Question
) where

import Choice.Choice

data Question = Question{
    choices  :: [Choice]
} deriving Show

generateQuestion :: [Choice] -> Question
generateQuestion n = do
    Question {choices = n}