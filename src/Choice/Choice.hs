module Choice.Choice(
    renderChoice,
    verifyCorrect,
    getAlternative,
    Choice
) where

import Data.Aeson
import Data.Text
import GHC.Generics

data Choice = Choice{
    description  :: String,
    correct :: Bool
} deriving (Show, Generic)

instance FromJSON Choice
instance ToJSON Choice

renderChoice :: Choice -> IO ()
renderChoice choice = do
    putStrLn (description choice)

verifyCorrect :: Choice -> Bool
verifyCorrect choice = (correct choice)

getAlternative :: Choice -> Char
getAlternative choice = (description choice !! 0)