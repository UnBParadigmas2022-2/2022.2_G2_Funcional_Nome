module View.View(
    showMainMenu,
    showScoreMenu,
    showFinalScore,
    showLoserScreen,
    showWinnerScreen,
    showNextQuestionMessage,
    showRightAnswerMessage,
    printLines,
    showActionsMenu,
    showHelpMenu,
    showPlatesResults,
    showStudentsResults,
    showCardsMenu,
    showCardsResults
    ) where

import Control.Monad
import Score.Score
import Help.Help

showMainMenu :: IO ()
showMainMenu = do
    putStrLn "========= Menu =========";
    putStrLn "1 - Start new game"
    putStrLn "2 - Exit"
    putStrLn "========================";

showScoreMenu :: Float -> IO ()
showScoreMenu currentScore = do
    putStrLn "========= Prize =========";
    when (currentScore > 0) (putStrLn ("Wrong Answer- $ " ++ show(updateScore 'l' currentScore) ++ "0"))
    when (currentScore > 0) (putStrLn ("Stop - $ " ++ show(updateScore 's' currentScore) ++ "0"))
    putStrLn ("Correct Answer - $ " ++ show(updateScore 'w' currentScore) ++ "0")
    putStrLn "==========================";

showActionsMenu :: HelpOptions -> IO ()
showActionsMenu helpOptions = do
    putStrLn "\n========= Help ========="
    putStrLn ("Skips: " ++ show(getNumSkips helpOptions))
    putStrLn ("Plates: " ++ show(getNumPlates helpOptions))
    putStrLn ("Students: " ++ show(getNumStudents helpOptions))
    putStrLn ("Cards: " ++ show(getNumCards helpOptions))

    putStrLn "\nTo use available help options type 'h'"
    putStrLn "==========================\n"

showFinalScore :: Float -> IO ()
showFinalScore finalScore = do
    putStrLn ("Your final score was: $ " ++ show(finalScore) ++ "0")

showLoserScreen :: IO ()
showLoserScreen = do
    putStrLn "Unfortunately you lose."

showWinnerScreen :: IO ()
showWinnerScreen = do
    putStrLn "Congratulations!! You got all questions right!!"

showRightAnswerMessage :: IO ()
showRightAnswerMessage = do
    putStrLn "You got it right!"

showNextQuestionMessage :: IO ()
showNextQuestionMessage = do
    putStrLn "Next question."

printLines :: Int -> IO ()
printLines 0 = return()
printLines lines = do
    putStrLn ""
    printLines (lines - 1)

showHelpMenu :: HelpOptions -> IO ()
showHelpMenu helpOptions = do
    putStrLn "\n========= Available help options ========="

    if getNumSkips helpOptions > 0
        then putStrLn ("1 - Skip")
    else do return ()

    if getNumPlates helpOptions > 0
        then putStrLn ("2 - Plates")
    else do return ()

    if getNumStudents helpOptions > 0
        then putStrLn ("3 - Students")
    else do return ()

    if getNumCards helpOptions > 0
        then putStrLn ("4 - Cards")
    else do return ()

    putStrLn ("5 - Go back")

    putStrLn "==========================================\n"

showPlateResult :: [Char] -> Int -> IO ()
showPlateResult [] _ = return ()
showPlateResult (head:tail) num = do
    putStrLn ((show num) ++ " - " ++ (show head))
    showPlateResult tail (num + 1)

showPlatesResults :: [Char] -> IO ()
showPlatesResults platesChoices = do
    putStrLn "\n========= Plates results ========="

    showPlateResult platesChoices 1

    putStrLn "==================================\n"

showStudentResult :: [Char] -> Int -> IO ()
showStudentResult [] _ = return ()
showStudentResult (head:tail) num = do
    putStrLn ((show num) ++ " - " ++ (show head))
    showStudentResult tail (num + 1)

showStudentsResults :: [Char] -> IO ()
showStudentsResults studentsChoices = do
    putStrLn "\n========= Students results ========="

    showStudentResult studentsChoices 1

    putStrLn "======================================\n"

showCardsMenu :: IO ()
showCardsMenu = do
    putStrLn "========= Cards options =========";
    putStrLn "1 - Card 1"
    putStrLn "2 - Card 2"
    putStrLn "3 - Card 3"
    putStrLn "4 - Card 4"
    putStrLn "Choose a card number"
    putStrLn "=================================";

showCardResult :: [Char] -> Int -> IO ()
showCardResult [] _ = return ()
showCardResult (head:tail) num = do
    putStrLn ((show num) ++ " - " ++ (show head))
    showCardResult tail (num + 1)

showCardsResults :: [Char] -> IO ()
showCardsResults removedChoices = do
    putStrLn "\n========= Cards results ========="

    showCardResult removedChoices 1

    putStrLn "===================================\n"
