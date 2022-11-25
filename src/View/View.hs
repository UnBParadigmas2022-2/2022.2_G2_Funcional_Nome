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
    showHelpMenu
    ) where

import Control.Monad
import Score.Score

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

showActionsMenu :: Int -> Int -> Int -> Int -> IO ()
showActionsMenu numSkips numPlates numStudents numCards = do
    putStrLn "\n========= Help ========="
    putStrLn ("Skips: " ++ show(numSkips))
    putStrLn ("Plates: " ++ show(numPlates))
    putStrLn ("Students: " ++ show(numStudents))
    putStrLn ("Cards: " ++ show(numCards))

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

showHelpMenu :: Int -> Int -> Int -> Int -> IO ()
showHelpMenu numSkips numPlates numStudents numCards = do
    putStrLn "\n========= Available help options ========="

    if numSkips > 0
        then putStrLn ("1 - Skip")
    else do return ()

    if numPlates > 0
        then putStrLn ("2 - Plates")
    else do return ()

    if numStudents > 0
        then putStrLn ("3 - Students")
    else do return ()

    if numCards > 0
        then putStrLn ("4 - Cards")
    else do return ()

    putStrLn ("5 - Go back")

    putStrLn "==========================\n"
