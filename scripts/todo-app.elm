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
  }
  
model = 
  { nextId = 1
  , textValue = ""
  , todos = []
  }
  
type Msg
  = AddTodo
  | TextValue String

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
        | todos =  model.todos ++ [ (Todo model.nextId model.textValue) ]
        , textValue = ""
        , nextId = model.nextId + 1
      }
      
    TextValue value ->
      { model | textValue = value } 
    
toTodo: Todo -> Html Msg
toTodo value =
  div [ id <| toString value.id ] [ text value.description ]
