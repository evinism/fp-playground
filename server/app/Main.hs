{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Spock
import Web.Spock.Config

import Control.Monad.Trans
import Data.Monoid
import Data.IORef
import qualified Data.Text as T

import Types
import qualified ProfileView
import qualified WelcomeView
import qualified App

data MySession = EmptySession
data MyAppState = DummyAppState (IORef AppModel)

main :: IO ()
main =
    do ref <- newIORef (0, [])
       spockCfg <- defaultSpockCfg EmptySession PCNoDatabase (DummyAppState ref)
       runSpock 8080 (spock spockCfg server)

server :: SpockM () MySession MyAppState ()
server =
    do get root $
           text $ WelcomeView.render
       get ("hello" <//> var) $ \name ->
           do (DummyAppState ref) <- getState
              appstate <- liftIO $ atomicModifyIORef' ref $ \state -> (App.updateApp state (UserVisited name), App.updateApp state (UserVisited name))
              html ( ProfileView.render appstate name )
