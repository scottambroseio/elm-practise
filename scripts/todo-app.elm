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
      [ input [ type_ "text", onInput TextValue ] []
      , button [ onClick AddTodo ] [ text "Add Todo" ]
      ]
    , List.map toTodo model.todos |> div []
    ]
    
update msg model =
  case msg of
    AddTodo ->
      { model
        | todos =  List.append model.todos [ model.textValue ]
        , textValue = ""
      }
      
    TextValue value ->
      { model | textValue = value } 
    
toTodo: String -> Html msg
toTodo value =
  p [] [ text value ]