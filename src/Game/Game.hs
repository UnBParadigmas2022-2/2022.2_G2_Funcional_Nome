module Game.Game(
    startGame
) where

import Data.Aeson
import qualified Data.ByteString.Lazy as Lazy
import Network.Wreq
import GHC.Generics
import Control.Lens

import Question.Question
import Choice.Choice
import Score.Score
import View.View
import Help.Help
import Random.Random

getApiQuestions :: IO [ApiQuestion]
getApiQuestions = do
    response <- asJSON =<< get "https://the-trivia-api.com/api/questions?limit=15"
    pure (response ^. responseBody)

startGame :: IO()
startGame = do
    putStrLn "Loading questions from Trivia API..."
    questions <- getApiQuestions
    printLines 100
    gameLoop (parseApiQuestions questions) 0 (createHelpOption 3 1 1 1) False

gameLoop :: [Question] -> Float -> HelpOptions -> Bool -> IO()
gameLoop questions currentScore helpOptions helpUsed = do
    if not helpUsed then showActionsMenu helpOptions
    else return ()

    showScoreMenu currentScore
    let actualQuestion = (Prelude.head questions)
    renderQuestion actualQuestion
    userAnswer <- getLine

    if userAnswer == "h" && not helpUsed
        then callHelpAction questions currentScore helpOptions
    else if userAnswer == "h" && helpUsed == True
        then do { printLines 100
                ; putStrLn "A help was already used in this question\n"
                ; gameLoop questions currentScore helpOptions True}
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
                gameLoop (Prelude.tail questions) (updateScore 'w' currentScore) helpOptions False

callHelpAction :: [Question] -> Float -> HelpOptions -> IO ()
callHelpAction questions score helpOptions = do
    showHelpMenu helpOptions
    input <- getLine
    printLines 100

    if input == "1" && getNumSkips helpOptions > 0
        then skipAction questions score helpOptions
    else if input == "2" && getNumPlates helpOptions > 0
        then plateAction questions score helpOptions
    else if input == "3" && getNumStudents helpOptions > 0
        then studentAction questions score helpOptions
    else if input == "4" && getNumCards helpOptions > 0
        then cardsAction questions score helpOptions
    else if input == "5"
        then do goBackAction questions score helpOptions
    else do
        putStrLn "Choose one option."
        callHelpAction questions score helpOptions

skipAction :: [Question] -> Float -> HelpOptions -> IO ()
skipAction questions score helpOptions = do
    if getNumSkips helpOptions < 1
        then do {
            putStrLn "No skips available"
            ; gameLoop questions score helpOptions False
        }
    else do
        let numSkips = getNumSkips helpOptions
        let numPlates = getNumPlates helpOptions
        let numStudents = getNumStudents helpOptions
        let numCards = getNumCards helpOptions

        gameLoop (Prelude.tail questions) score (createHelpOption (numSkips - 1) numPlates numStudents numCards) False

getChoiceFromPlateAccuracy :: [Question] -> Bool -> Char
getChoiceFromPlateAccuracy questions plateAccuracy
    | plateAccuracy == True = getCorrectAnswer choices
    | otherwise = getAlternative ((filter notCorrect choices) !! randomIdx)
    where
        choices = getChoices (Prelude.head questions)
        randomIdx = randomIntInRange 0 ((length choices) - 2)

plateAction :: [Question] -> Float -> HelpOptions -> IO ()
plateAction questions score helpOptions = do
    if getNumPlates helpOptions < 1
        then do {
            putStrLn "Plates unavailable"
            ; gameLoop questions score helpOptions False
        }
    else do
        let numSkips = getNumSkips helpOptions
        let numPlates = getNumPlates helpOptions
        let numStudents = getNumStudents helpOptions
        let numCards = getNumCards helpOptions

        let platesChoices = map (\x -> getChoiceFromPlateAccuracy questions x) platesValuesAccuracy

        showPlatesResults platesChoices

        gameLoop questions score (createHelpOption numSkips (numPlates - 1) numStudents numCards) True

getChoiceFromStudentAccuracy :: [Question] -> Bool -> Char
getChoiceFromStudentAccuracy questions plateAccuracy
    | plateAccuracy == True = getCorrectAnswer choices
    | otherwise = getAlternative ((filter notCorrect choices) !! randomIdx)
    where
        choices = getChoices (Prelude.head questions)
        randomIdx = randomIntInRange 0 ((length choices) - 2)

studentAction :: [Question] -> Float -> HelpOptions -> IO ()
studentAction questions score helpOptions = do
    if getNumStudents helpOptions < 1
        then do {
            putStrLn "Students unavailable"
            ; gameLoop questions score helpOptions False
        }
    else do
        let numSkips = getNumSkips helpOptions
        let numPlates = getNumPlates helpOptions
        let numStudents = getNumStudents helpOptions
        let numCards = getNumCards helpOptions

        let studentsChoices = map (\x -> getChoiceFromStudentAccuracy questions x) studentsValuesAccuracy

        showStudentsResults studentsChoices

        gameLoop questions score (createHelpOption numSkips numPlates (numStudents - 1) numCards) True

filterNWrongChoices :: Question -> Int -> [Char]
filterNWrongChoices question n = do
    let choices = take n (filter notCorrect (getChoices question))

    map getAlternative choices

cardsAction :: [Question] -> Float -> HelpOptions -> IO ()
cardsAction questions score helpOptions = do
    if getNumCards helpOptions < 1
        then do {
            putStrLn "Cards unavailable"
            ; gameLoop questions score helpOptions False
        }
    else do
        let numSkips = getNumSkips helpOptions
        let numPlates = getNumPlates helpOptions
        let numStudents = getNumStudents helpOptions
        let numCards = getNumCards helpOptions
        let cards = cardsValues

        showCardsMenu

        userAnswer <- getLine
        let intAnswer = (read userAnswer) :: Int

        if intAnswer < 1 || intAnswer > 4
            then do { putStrLn "Invalid card"
                    ; gameLoop questions score helpOptions False}
        else do
            let removedQuestions = cards !! (intAnswer - 1)

            putStrLn ("\n" ++ (show removedQuestions) ++ " question(s) was(where) eliminated\n")

            if removedQuestions > 0
                then showCardsResults (filterNWrongChoices (head questions) removedQuestions)
            else return ()

            gameLoop questions score (createHelpOption numSkips numPlates numStudents (numCards - 1)) True

goBackAction :: [Question] -> Float -> HelpOptions -> IO ()
goBackAction questions score helpOptions = do
    printLines 100
    gameLoop questions score helpOptions False
