-- http://elm-lang.org/try to see
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Date exposing (Date)
import Task

main = 
  program { init = init, view = view, update = update, subscriptions = subscriptions }

type alias Model =
  { nextId: Int
  , textValue: String
  , todos: List Todo
  , date: Maybe Date
  }
  
type alias Todo =
  { id: Int
  , description: String
  , completed: Bool
  }
  
init =
  let
    model = 
      { nextId = 0
      , textValue = ""
      , todos = []
      , date = Nothing
      }
  in
    (model, Task.perform NewDate Date.now)
  
type Msg
  = AddTodo
  | TextValue String
  | ToggleCompleted Int
  | DeleteTodo Int
  | NewDate (Date)

view : Model -> Html Msg
view model =
  div [] 
    [ h1 [] [ text "Todos" ]
    , div []
      [ input [ type_ "text", onInput TextValue, value model.textValue ] []
      , button [ onClick AddTodo ] [ text "Add Todo" ]
      ]
    , List.map toTodo model.todos |> div []
    , div []
      [ p [] [ getDate model ]
      ]
    ]
    
getDate model =
  case model.date of
    Nothing -> text ""
    Just date -> toString date |> text

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    AddTodo ->
      ({ model
        | todos =  model.todos ++ [ (Todo model.nextId model.textValue False) ]
        , textValue = ""
        , nextId = model.nextId + 1
      }, Cmd.none)
      
    TextValue value ->
      ({ model | textValue = value }, Cmd.none)
      
    ToggleCompleted id ->
      let
        toggleCompleted todo =
          if todo.id == id then
            { todo | completed = not todo.completed }
          else
            todo
      in
        ({ model | todos = List.map toggleCompleted model.todos }, Cmd.none)
    DeleteTodo id ->
      ({ model | todos = List.filter (\t -> t.id /= id) model.todos }, Cmd.none)
    NewDate date ->
      ({ model | date = Just date }, Cmd.none)

toTodo: Todo -> Html Msg
toTodo value =
  if value.completed == True then
    div [ onClick (ToggleCompleted value.id) ]
    [ p [ style [("text-decoration", "line-through")] ] [text value.description]
    , button [ onClick (DeleteTodo value.id) ] [ text "Delete" ]
    ]
  else
    div [ onClick (ToggleCompleted value.id) ]
    [ p [] [text value.description]
    , button [ onClick (DeleteTodo value.id) ] [ text "Delete" ]
    ]    
subscriptions model =
  Sub.none
