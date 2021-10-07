{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Control.Exception
import           Control.Monad                (void)
import           Data.Aeson                   (Value (Array, String), object)
import           Data.Vector                  (fromList)
import           System.Environment           (getArgs)
import           Test.WebDriver
import           Test.WebDriver.Commands.Wait
import           Utils


--firefoxConfig = useBrowser firefox { ffBinary=Just firefoxBin, ffAcceptInsecureCerts=Just True } defaultConfig { wdCapabilities = defaultCaps { additionalCaps = [ ("moz:firefoxOptions", object [ ("args", Array (fromList [String "--headless", String "--window-size=1050,1080"])) ]) ] } }

main :: IO ()
main = do
  firefoxConfig <- setup
  run firefoxConfig

setup :: IO WDConfig
setup = do
  args <- getArgs
  let nargs = length args
  let ci = if nargs > 0 then read (args!!0) else False
  let firefoxBin = if ci then "/opt/hostedtoolcache/firefox/latest/x64/firefox" else "/usr/bin/firefox"
  return $ useBrowser firefox { ffBinary=Just firefoxBin, ffAcceptInsecureCerts=Just True } defaultConfig

run :: WDConfig -> IO ()
run ffConfig = runSession ffConfig . closeOnException $ do -- . finallyClose $ do

  setImplicitWait    5000
  setPageLoadTimeout 5000

  openPage "https://localhost:8009"
  --openPage "https://cardano.org/"

  --clickElem "//a[@role='button']/span[text()='Discover Cardano']"
  waitForElem "//span[text() = 'Plutus playground']"

  waitForElem "//h1[contains(text(), 'Discover')]"

  assertURL "https://cardano.org/discover-cardano/"

  clickElem "//img[@alt='Cardano Organisation']"

  waitForElem "//h1[contains(text(), 'Making the world')]"

  assertURL "https://cardano.org/"

  closeSession

