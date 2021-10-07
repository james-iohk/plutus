{-# LANGUAGE OverloadedStrings #-}

module Utils where

import           Control.Monad                (void)
import           Data.CallStack
import           Data.Text                    (Text)
import           Prelude
import           Test.WebDriver
import           Test.WebDriver.Class
import           Test.WebDriver.Commands.Wait

assertTrue :: (WebDriver wd) => Bool -> String -> wd ()
assertTrue a e
         | a         = return ()
         | otherwise = unexpected e

assertURL :: (WebDriver wd) => String -> wd ()
assertURL s = do
    url <- getCurrentURL
    assertTrue (url == s) ("Actual URL: " ++ url ++ " Expected URL: " ++ s)

waitForElem :: (WebDriver wd) => Text -> wd Element
waitForElem xp = waitUntil 10 $ findElem $ ByXPath xp

clickElem :: (WebDriver wd) => Text -> wd ()
clickElem xp = do
    e <- waitForElem xp
    click e
