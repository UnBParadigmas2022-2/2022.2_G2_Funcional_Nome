{-# LANGUAGE DeriveGeneric #-}
module ApiQuestions.ApiQuestions (
    getQuestion,
    request
) where

import Network.Wreq
import Data.Text (Text)  
import Data.Aeson
import GHC.Generics
import Control.Lens

data Questions = Questions {
    category :: Text,
    correctAnswer :: Text,
    incorrectAnswers :: [Text],
    question:: Text,
    difficulty :: Text
} deriving (Show, Generic)

instance FromJSON Questions

getQuestion :: IO [Questions]
getQuestion = do
    response <- asJSON =<< get "https://the-trivia-api.com/api/questions?limit=15"
    pure (response ^. responseBody)

request :: IO ()
request = do
    quest <- getQuestion
    -- Printando na tela apenas para verificar se está consumindo corretamente da api. Apagar depois
    print quest   