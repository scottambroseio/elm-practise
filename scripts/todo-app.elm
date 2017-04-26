import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

main = 
  beginnerProgram { model = model, view = view, update = update }

type alias Model =
  { textValue: String
  , todos: List String
  }
  
model = 
  { textValue = ""
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
        | todos =  model.todos ++ [ model.textValue ]
        , textValue = ""
      }
      
    TextValue value ->
      { model | textValue = value } 
    
toTodo: String -> Html Msg
toTodo value =
  p [] [ text value ]
