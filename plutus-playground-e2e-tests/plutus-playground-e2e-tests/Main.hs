{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Control.Exception
import           Control.Monad                (void)
import           Data.Aeson                   (Value (Array, String), object)
import           Data.Vector                  (fromList)
import           Elements                     as E
import           System.Environment           (getArgs)
import           Test.WebDriver
import           Test.WebDriver.Class
import           Test.WebDriver.Commands.Wait
import           Utils


--firefoxConfig = useBrowser firefox { ffBinary=Just firefoxBin, ffAcceptInsecureCerts=Just True } defaultConfig { wdCapabilities = defaultCaps { additionalCaps = [ ("moz:firefoxOptions", object [ ("args", Array (fromList [String "--headless", String "--window-size=1050,1080"])) ]) ] } }

main :: IO ()
main = do
  firefoxConfig <- setupFFConfig
  runTests firefoxConfig

setupFFConfig :: IO WDConfig
setupFFConfig = do
  args <- getArgs
  let nargs = length args
  let ci = if nargs > 0 then read (args!!0) else False
  let firefoxBin = if ci then "/opt/hostedtoolcache/firefox/latest/x64/firefox" else "/usr/bin/firefox"
  return $ useBrowser firefox { ffBinary=Just firefoxBin, ffAcceptInsecureCerts=Just True } defaultConfig

runTests :: WDConfig -> IO ()
runTests browserConfig = runSession browserConfig . closeOnException $ do

  --setImplicitWait    5000
  setPageLoadTimeout 5000

  runHelloWorldTest
  runHelloWorldTest

  closeSession

runHelloWorldTest :: (WebDriver wd) => wd ()
runHelloWorldTest = do

  openPage playgroundUrl

  waitForElem E.header
  bodyElem <- getElem E.body

  feedbackHeaderElem <- getElem E.feedbackHeader
  assertText feedbackHeaderElem "Not compiled"

  clickElem E.helloWorldDemoLnk
  helloWorldTextElem <- waitForElem E.helloWorldEditorText

  assertText feedbackHeaderElem "Compilation successful"

  click helloWorldTextElem
  let insertText = "wonderful"
  sendKeys insertText bodyElem

  assertText feedbackHeaderElem "Code changed since last compilation"

  clickElem compileBtn
  assertText feedbackHeaderElem "Compiling ..."
  waitForElemText feedbackHeaderElem "Compilation successful"

  clickElem simulateBtn
  waitForElem walletsHeader

  clickElem evaluateBtn
  waitForElem transactionsHeader
  void $  waitForElem $ logsText insertText

