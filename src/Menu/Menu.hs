module Menu.Menu(
    mainMenu
    ) where

import Game.Game
import View.View

mainMenu :: IO ()
mainMenu = do
    showMainMenu
    input <- getLine
    printLines 100

    if input == "1"
        then startGame
    else if input == "2"
        then putStrLn "Program exited."
    else do
        putStrLn "Choose one option."
        mainMenu;
