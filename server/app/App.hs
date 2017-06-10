{-# LANGUAGE OverloadedStrings #-}
module App where
import Types

import qualified Data.Text as T

incrementInRecords :: T.Text -> [ UserRecord ] -> [ UserRecord ]
incrementInRecords name = map (\user -> (fst user, if (fst user) == name then snd user + 1 else snd user ))

appendVisitor :: AppModel -> T.Text -> AppModel
appendVisitor state name =
  let userRecords = snd state
  in (
    fst state + 1,
    if length (filter (\user -> (fst user == name)) userRecords) == 0
      then ( name, 1 ) : userRecords
      else (incrementInRecords name userRecords)
  )

-- not sure t.text makes sense here, but whatever
updateApp :: AppModel -> Msg T.Text -> AppModel
updateApp model (UserVisited name) = appendVisitor model name
