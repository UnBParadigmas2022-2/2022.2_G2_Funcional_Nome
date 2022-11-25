module Game.Game(
    startGame
) where

import Data.Aeson
import qualified Data.ByteString.Lazy as Lazy

import Question.Question
import Score.Score
import View.View
import Help.Help

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

startGame :: IO()
startGame = do
    questions <- parseQuestions
    gameLoop questions 0 (createHelpOption 3 1 1 1)

gameLoop :: [Question] -> Float -> HelpOptions -> IO()
gameLoop questions currentScore helpOptions = do
    showActionsMenu helpOptions
    showScoreMenu currentScore
    let actualQuestion = (Prelude.head questions)
    renderQuestion actualQuestion
    userAnswer <- getLine

    if userAnswer == "h"
        then callHelpAction questions currentScore helpOptions
    else do
        if ((checkUserAnswer userAnswer (getCorrectAnswer (getChoices actualQuestion))) == 0)
        then do { printLines 100
                ; showLoserScreen
                ; showFinalScore (updateScore 'l' currentScore)}
        else do
            showRightAnswerMessage
            if (Prelude.null (Prelude.tail questions) == True)
                then do { printLines 100
                        ; showWinnerScreen
                        ; showFinalScore (updateScore 'w' currentScore)}
            else do
                printLines 100
                showNextQuestionMessage
                gameLoop (Prelude.tail questions) (updateScore 'w' currentScore) helpOptions

callHelpAction :: [Question] -> Float -> HelpOptions -> IO ()
callHelpAction questions score helpOptions = do
    showHelpMenu helpOptions
    input <- getLine
    printLines 100

    if input == "1"
        then skipAction
    else if input == "2"
        then plateAction
    else if input == "3"
        then studentAction
    else if input == "4"
        then cardsAction
    else if input == "5"
        then do goBackAction questions score helpOptions
    else do
        putStrLn "Choose one option."
        callHelpAction questions score helpOptions

-- skipAction :: [Question] -> Float -> IO ()
skipAction = putStrLn "skipAction"

-- plateAction :: [Question] -> Float -> IO ()
plateAction = putStrLn "plateAction"

-- studentAction :: [Question] -> Float -> IO ()
studentAction = putStrLn "studentAction"

-- cardsAction :: [Question] -> Float -> IO ()
cardsAction = putStrLn "cardsAction"

goBackAction :: [Question] -> Float -> HelpOptions -> IO ()
goBackAction questions score helpOptions = do
    printLines 100
    gameLoop questions score helpOptions
