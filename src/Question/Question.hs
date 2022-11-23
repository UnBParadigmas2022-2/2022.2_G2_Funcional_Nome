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
    mapM renderChoice (choices question)
    verifyAnswer question
    
verifyAnswer :: Question -> IO ()
verifyAnswer question = do
    input <- getLine
    let answer = getCorrectAnswer (choices question)
  
    if (input !! 0) == answer
        then putStrLn "Acertou!"
    else do
        putStrLn "Errou!"

getCorrectAnswer :: [Choice] -> Char
getCorrectAnswer [x] = 'd'
getCorrectAnswer (h:t) | verifyCorrect h == True = getAlternative h
                       | otherwise = getCorrectAnswer t