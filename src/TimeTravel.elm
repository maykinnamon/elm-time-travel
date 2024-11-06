module TimeTravel exposing (addTimeTravel)

import Playground exposing (..)
import Set

controlBarHeight = 64

addTimeTravel rawGame =
  { initialState = initialStateWithTimeTravel rawGame
  , updateState = updateWithTimeTravel rawGame
  , view = viewWithTimeTravel rawGame
  }

initialStateWithTimeTravel rawGame =
  {rawModel = rawGame.initialState 
  , paused = False}

viewWithTimeTravel rawGame computer model =
  let
    helpMessage =
        if model.paused then
          "Press R to resume"
        else
          "Press T to time travel"
  in
    (rawGame.view computer model.rawModel) ++
      [ words white helpMessage
          |> move 0 (computer.screen.top - controlBarHeight / 2)
      ]


updateWithTimeTravel rawGame computer model =
  if keyPressed "T" computer then 
    {model | paused = True}
  else if keyPressed "R" computer then  
    {model | paused = False}
  else if model.paused then
    model
  else 
    { model | rawModel = rawGame.updateState computer model.rawModel }


keyPressed keyName computer =
  [ String.toLower keyName
  , String.toUpper keyName
  ]
    |> List.any (\key -> Set.member key computer.keyboard.keys)