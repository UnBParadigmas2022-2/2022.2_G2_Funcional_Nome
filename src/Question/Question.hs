{-# LANGUAGE DeriveGeneric #-}
module Question.Question(
    renderQuestion,
    getCorrectAnswer,
    checkUserAnswer,
    Question
) where

import Data.Aeson
-- import Data.Text
import GHC.Generics

-- import Choice.Choice

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
    -- renderChoiceRecursive allChoices 
    mapM_ putStrLn (shuffleChoices allChoices ((length (correctAnswer questionObj)) `mod` 4))  

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

getCorrectAnswer :: Question -> String
getCorrectAnswer question = correctAnswer question

shuffleChoices :: [String] -> Int -> [String]
shuffleChoices choices seed  
    | seed == 0 = choices
    | seed == 1 = reverse choices
    | seed == 2 = (Prelude.tail choices) ++ [(Prelude.head choices)]
    | seed == 3 = reverse ((Prelude.tail choices) ++ [(Prelude.head choices)])


checkUserAnswer :: String -> String -> Int
checkUserAnswer userAnswer questionAnswer 
    | userAnswer == questionAnswer = 1
    | otherwise = 0
