module Menu.Menu( 
    mainMenu 
    ) where 

import Game.Game

mainMenu :: IO ()
mainMenu = do 
    putStrLn "========= Menu =========";
    putStrLn "1 - Comecar novo jogo"
    putStrLn "2 - Parar"
    input <- getLine

    if input == "1"
        then startGame
    else if input == "2"
        then putStrLn "Program exited."
    else do
        putStrLn "Choose one option."
        mainMenu;