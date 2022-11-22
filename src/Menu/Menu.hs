module Menu.Menu( 
    mainMenu 
    ) where 

mainMenu :: IO ()
mainMenu = do 
    putStrLn "========= Menu =========";
    putStrLn "1 - Start the game"
    putStrLn "2 - Exit"
    input <- getLine

    if input == "1"
        then putStrLn "Game started"
    else if input == "2"
        then putStrLn "Program exited."
    else do
        putStrLn "Choose one option."
        mainMenu;