{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Control.Exception
import           Control.Monad                (void)
import           Prelude
import           Test.WebDriver
import           Test.WebDriver.Commands.Wait
import           Utils

firefoxConfig :: WDConfig
firefoxConfig = useBrowser firefox { ffBinary=Just "/usr/bin/firefox", ffAcceptInsecureCerts=Just True } defaultConfig

main :: IO ()
main = runSession firefoxConfig . finallyClose $ do

  setImplicitWait    5000
  setPageLoadTimeout 5000

  openPage "https://localhost:8009"

  clickElem "//a[@role='button']/span[text()='Discover Cardano']"

  waitForElem "//h1[contains(text(), 'Discover')]"

  assertURL "https://cardano.org/discover-cardanooo/"

  clickElem "//img[@alt='Cardano Organisation']"

  waitForElem "//h1[contains(text(), 'Making the world')]"

  assertURL "https://cardano.org/"

  closeSession

