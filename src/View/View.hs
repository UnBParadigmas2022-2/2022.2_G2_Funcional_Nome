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
    showStudentsResults
    ) where

import Control.Monad
import Score.Score
import Help.Help

showMainMenu :: IO ()
showMainMenu = do
    putStrLn "========= Menu =========";
    putStrLn "1 - Comecar novo jogo"
    putStrLn "2 - Parar"
    putStrLn "========================";

showScoreMenu :: Float -> IO ()
showScoreMenu currentScore = do
    putStrLn "========= Premio =========";
    when (currentScore > 0) (putStrLn ("Errar - RS " ++ show(updateScore 'l' currentScore) ++ "0"))
    when (currentScore > 0) (putStrLn ("Parar - RS " ++ show(updateScore 's' currentScore) ++ "0"))
    putStrLn ("Acertar - RS " ++ show(updateScore 'w' currentScore) ++ "0")
    putStrLn "==========================\n";

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
    putStrLn ("Seu premio final foi de: RS " ++ show(finalScore) ++ "0")

showLoserScreen :: IO ()
showLoserScreen = do
    putStrLn "Infelizmente voce perdeu."

showWinnerScreen :: IO ()
showWinnerScreen = do
    putStrLn "Parabens! Acertou todas as questões"

showRightAnswerMessage :: IO ()
showRightAnswerMessage = do
    putStrLn "Acertou!"

showNextQuestionMessage :: IO ()
showNextQuestionMessage = do
    putStrLn "Próxima questão"

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
