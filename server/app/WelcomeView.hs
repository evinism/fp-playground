{-# LANGUAGE OverloadedStrings #-}
module WelcomeView where

import Types
import qualified Data.Text as T
import Data.Monoid

render :: T.Text
render = "Hello World!"
