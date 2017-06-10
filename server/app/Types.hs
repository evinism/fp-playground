module Types where

import qualified Data.Text as T

type UserRecord = (T.Text, Int)
type AppModel = (Int, [ UserRecord ])

data Msg a = UserVisited a
