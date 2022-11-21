module Choice.Choice(
    Choice
) where

import Data.Aeson
import Data.Text
import GHC.Generics

data Choice = Choice{
    description  :: Text,
    correct :: Bool
} deriving (Show, Generic)

instance FromJSON Choice
instance ToJSON Choice