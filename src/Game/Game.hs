module Game.Game(
    startGame
) where

import Data.Aeson
import qualified Data.ByteString.Lazy as Lazy

import Question.Question
import Choice.Choice
import Score.Score
import View.View
import Help.Help
import Random.Random

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
    gameLoop questions 0 (createHelpOption 3 1 1 1) False

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
    else if input == "3"
        then studentAction
    else if input == "4"
        then cardsAction
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

-- studentAction :: [Question] -> Float -> IO ()
studentAction = putStrLn "studentAction"

-- cardsAction :: [Question] -> Float -> IO ()
cardsAction = putStrLn "cardsAction"

goBackAction :: [Question] -> Float -> HelpOptions -> IO ()
goBackAction questions score helpOptions = do
    printLines 100
    gameLoop questions score helpOptions False
