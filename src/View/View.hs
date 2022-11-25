module View.View(
    showMainMenu,
    showScoreMenu,
    showFinalScore,
    showLoserScreen,
    showWinnerScreen,
    showNextQuestionMessage,
    showRightAnswerMessage,
    printLines
    ) where

import Control.Monad
import Score.Score

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
