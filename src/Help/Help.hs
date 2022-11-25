{-# LANGUAGE DeriveGeneric #-}
module Help.Help(
    getNumSkips,
    getNumPlates,
    getNumStudents,
    getNumCards,
    createHelpOption,
    HelpOptions
    ) where

import GHC.Generics

data HelpOptions = HelpOptions{
    numSkips :: Int,
    numPlates :: Int,
    numStudents :: Int,
    numCards :: Int
} deriving (Show, Generic)

getNumSkips :: HelpOptions -> Int
getNumSkips helpOptions = (numSkips helpOptions)

getNumPlates :: HelpOptions -> Int
getNumPlates helpOptions = (numPlates helpOptions)

getNumStudents :: HelpOptions -> Int
getNumStudents helpOptions = (numStudents helpOptions)

getNumCards :: HelpOptions -> Int
getNumCards helpOptions = (numCards helpOptions)

createHelpOption :: Int -> Int -> Int -> Int -> HelpOptions
createHelpOption numSkips numPlates numStudents numCards = HelpOptions numSkips numPlates numStudents numCards
