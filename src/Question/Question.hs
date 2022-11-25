{-# LANGUAGE DeriveGeneric #-}
module Question.Question(
    renderQuestion,
    getCorrectAnswer,
    checkUserAnswer,
    Question
) where

import Data.Aeson
import GHC.Generics

data Question = Question{
    category :: String,
    correctAnswer :: String,
    incorrectAnswers :: [String],
    question:: String,
    difficulty :: String
} deriving (Show, Generic)

instance FromJSON Question
instance ToJSON Question

renderQuestion :: Question -> IO ()
renderQuestion questionObj = do
    putStrLn (question questionObj)
    let allChoices = (incorrectAnswers questionObj) ++ [(correctAnswer questionObj)]
    renderChoiceRecursive (shuffleChoices allChoices ((length (correctAnswer questionObj)) `mod` 4))

renderChoiceRecursive :: [String] -> IO()
renderChoiceRecursive [x] = putStrLn ("D) " ++ x)
renderChoiceRecursive (h:t) | length t == 3 = do 
                                putStrLn ("A) " ++ h)
                                renderChoiceRecursive t
                            | length t == 2 = do
                                putStrLn ("B) " ++ h)
                                renderChoiceRecursive t
                            | length t == 1 = do
                                putStrLn ("C) " ++ h)
                                renderChoiceRecursive t

getCorrectAnswer :: Question -> Char
getCorrectAnswer question 
    | seed == 0 = 'D'
    | seed == 1 = 'A'
    | seed == 2 = 'C'
    | seed == 3 = 'B'
    where 
        seed = (length (correctAnswer question)) `mod` 4


shuffleChoices :: [String] -> Int -> [String]
shuffleChoices choices seed  
    | seed == 0 = choices
    | seed == 1 = reverse choices
    | seed == 2 = (Prelude.tail choices) ++ [(Prelude.head choices)]
    | seed == 3 = reverse ((Prelude.tail choices) ++ [(Prelude.head choices)])


checkUserAnswer :: [Char] -> Char -> Int
checkUserAnswer userAnswer questionAnswer 
    | userAnswer !! 0 == questionAnswer = 1
    | otherwise = 0
