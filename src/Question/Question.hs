{-# LANGUAGE DeriveGeneric #-}
module Question.Question(
    renderQuestion,
    checkUserAnswer,
    getCorrectAnswer,
    getChoices,
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

renderQuestion :: Question -> IO [()]
renderQuestion question = do
    putStrLn (description question) 
    mapM renderChoice (choices question)

getCorrectAnswer :: [Choice] -> Char
getCorrectAnswer [x] = 'd'
getCorrectAnswer (h:t) | verifyCorrect h == True = getAlternative h
                       | otherwise = getCorrectAnswer t

checkUserAnswer :: [Char] -> Char -> Int
checkUserAnswer userAnswer questionAnswer 
    | userAnswer !! 0 == questionAnswer = 1
    | otherwise = 0

getChoices :: Question -> [Choice]
getChoices question = choices question