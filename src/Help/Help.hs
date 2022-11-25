{-# LANGUAGE DeriveGeneric #-}
module Help.Help(
    getNumSkips,
    getNumPlates,
    getNumStudents,
    getNumCards,
    createHelpOption,
    platesValuesAccuracy,
    studentsValuesAccuracy,
    HelpOptions
    ) where

import GHC.Generics
import Random.Random

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

platesValuesAccuracy :: [Bool]
platesValuesAccuracy = [randomPercentageChance x | x <- [35, 45, 55, 59]]

studentsValuesAccuracy :: [Bool]
studentsValuesAccuracy = [randomPercentageChance x | x <- [65, 75, 75]]
