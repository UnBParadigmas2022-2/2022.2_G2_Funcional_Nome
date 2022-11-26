{-# LANGUAGE DeriveGeneric #-}
module Question.Question(
    renderQuestion,
    checkUserAnswer,
    getCorrectAnswer,
    getChoices,
    getApiQuestionQuestion,
    getApiQuestionCorrectAnswer,
    getApiQuestionIncorrectAnswers,
    createQuestion,
    shuffleChoices,
    allChoices,
    parseApiQuestions,
    Question,
    ApiQuestion
) where

import Data.Aeson
import GHC.Generics

import Choice.Choice

data ApiQuestion = ApiQuestion{
    category :: String,
    correctAnswer :: String,
    incorrectAnswers :: [String],
    question:: String
} deriving (Show, Generic)

data Question = Question{
    description :: String,
    choices  :: [Choice]
} deriving (Show, Generic)

instance FromJSON ApiQuestion
instance ToJSON ApiQuestion

createQuestion :: String -> [Choice] -> Question
createQuestion description choices = Question description choices

renderQuestion :: Question -> IO [()]
renderQuestion question = do
    putStrLn (description question)
    mapM renderChoice (choices question)

getCorrectAnswer :: [Choice] -> Char
getCorrectAnswer [x] = 'd'
getCorrectAnswer (h:t)
    | verifyCorrect h == True = getAlternative h
    | otherwise = getCorrectAnswer t

checkUserAnswer :: [Char] -> Char -> Int
checkUserAnswer userAnswer questionAnswer
    | userAnswer !! 0 == questionAnswer = 1
    | otherwise = 0

getChoices :: Question -> [Choice]
getChoices question = choices question

getApiQuestionQuestion :: ApiQuestion -> String
getApiQuestionQuestion apiQuestion = (question apiQuestion)

getApiQuestionCorrectAnswer :: ApiQuestion -> String
getApiQuestionCorrectAnswer apiQuestion = (correctAnswer apiQuestion)

getApiQuestionIncorrectAnswers :: ApiQuestion -> [String]
getApiQuestionIncorrectAnswers apiQuestion = (incorrectAnswers apiQuestion)

allChoices :: ApiQuestion -> [String]
allChoices apiQuestion = (incorrectAnswers apiQuestion) ++ [(correctAnswer apiQuestion)]

shuffleChoices :: [String] -> Int -> [String]
shuffleChoices choices seed
    | seed == 0 = choices
    | seed == 1 = Prelude.reverse choices
    | seed == 2 = (Prelude.tail choices) ++ [(Prelude.head choices)]
    | seed == 3 = Prelude.reverse ((Prelude.tail choices) ++ [(Prelude.head choices)])

parseChoice :: String -> String -> Bool -> Choice
parseChoice question alternative correct = do
    createChoice (alternative ++ ")" ++ question) correct

choiceAlternativeFromIndex :: Int -> String
choiceAlternativeFromIndex idx
    | idx == 0 = "a"
    | idx == 1 = "b"
    | idx == 2 = "c"
    | idx == 3 = "d"
    | otherwise = "?"

parseChoices :: [String] -> Int -> String -> [Choice]
parseChoices [] _ _ = []
parseChoices (head:tail) idx correctAnswer = do
    [(parseChoice head (choiceAlternativeFromIndex idx) (correctAnswer == head))] ++ (parseChoices tail (idx + 1) correctAnswer)


parseApiQuestions :: [ApiQuestion] -> [Question]
parseApiQuestions [] = []
parseApiQuestions (head:tail) = do
    let question = getApiQuestionQuestion head
    let correctAnswer = getApiQuestionCorrectAnswer head
    let incorrectAnswers = getApiQuestionIncorrectAnswers head

    [(createQuestion question (parseChoices (allChoices head) 0 (show correctAnswer)))] ++ (parseApiQuestions tail)
