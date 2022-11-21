module Choice.Choice(
    renderChoice,
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