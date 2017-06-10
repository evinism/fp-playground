{-# LANGUAGE OverloadedStrings #-}
module ProfileView where

import Types
import qualified Data.Text as T
import Data.Monoid


makeVisitorGreeting :: T.Text -> Int -> T.Text
makeVisitorGreeting name num = "Hello " <> name <> ", you are visitor number " <> T.pack (show num)

join :: [String] -> String -> String
join list delim = ((foldr (++) "" (map (++ delim) list)))

recordToLi :: UserRecord -> String
recordToLi record = ("<li>" ++ (show $ fst record) ++ ": " ++ (show $ snd record) ++ "</li>")

makeUsersList :: AppModel -> T.Text
makeUsersList appstate =
  T.pack ("<div>prev users: <ul>" ++ (foldr (++) "" (map recordToLi (snd appstate)) ) ++ "</ul></div>")

render :: AppModel -> T.Text -> T.Text
render appstate name = (makeVisitorGreeting name (fst appstate)) <> ", " <> (makeUsersList appstate)
