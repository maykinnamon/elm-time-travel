module TimeTravel exposing (addTimeTravel)

import Playground exposing (..)
import Set

addTimeTravel rawGame =
  { initialState = initialStateWithTimeTravel rawGame
  , updateState = updateWithTimeTravel rawGame
  , view = viewWithTimeTravel rawGame
  }

initialStateWithTimeTravel rawGame =
  {rawModel = rawGame.initialState 
  , paused = False}

viewWithTimeTravel rawGame computer model =
  rawGame.view computer model.rawModel

updateWithTimeTravel rawGame computer model =
  { model | rawModel = rawGame.updateState computer model.rawModel }