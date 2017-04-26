-- http://elm-lang.org/try to see
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

main = 
  beginnerProgram { model = model, view = view, update = update }

type alias Model =
  { nextId: Int
  , textValue: String
  , todos: List Todo
  }
  
type alias Todo =
  { id: Int
  , description: String
  , completed: Bool
  }
  
model = 
  { nextId = 1
  , textValue = ""
  , todos = []
  }
  
type Msg
  = AddTodo
  | TextValue String
  | ToggleCompleted Int

view : Model -> Html Msg
view model =
  div [] 
    [ h1 [] [ text "Todos" ]
    , div []
      [ input [ type_ "text", onInput TextValue, value model.textValue ] []
      , button [ onClick AddTodo ] [ text "Add Todo" ]
      ]
    , List.map toTodo model.todos |> div []
    ]

update: Msg -> Model -> Model
update msg model =
  case msg of
    AddTodo ->
      { model
        | todos =  model.todos ++ [ (Todo model.nextId model.textValue False) ]
        , textValue = ""
        , nextId = model.nextId + 1
      }
      
    TextValue value ->
      { model | textValue = value }
      
    ToggleCompleted id ->
      let
        toggleCompleted todo =
          if todo.id == id then
            { todo | completed = not todo.completed }
          else
            todo
      in
        { model | todos = List.map toggleCompleted model.todos }
    
toTodo: Todo -> Html Msg
toTodo value =
  if value.completed == True then
    p [ style [("text-decoration", "line-through")], onClick (ToggleCompleted value.id) ] [ text value.description ]
  else
    p [ onClick (ToggleCompleted value.id) ] [ text value.description ]
