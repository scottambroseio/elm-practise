import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Date exposing (..)
import Date.Format exposing (format)
import Task

main =
  program { init = init, view = view, update = update, subscriptions = subscriptions }

type alias Model =
  { nextId: Int
  , textValue: String
  , todos: List Todo
  }

type alias Todo =
  { id: Int
  , description: String
  , completed: Bool
  , date: Maybe Date
  }

init =
  let
    model =
      { nextId = 0
      , textValue = ""
      , todos = []
      }
  in
    (model, Cmd.none)

type Msg
  = AddTodo
  | TextValue String
  | ToggleCompleted Int
  | DeleteTodo Int
  | AddDateToTodo Int Date

view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text "Todos" ]
    , div []
      [ input [ type_ "text", onInput TextValue, value model.textValue ] []
      , button [ onClick AddTodo ] [ text "Add Todo" ]
      ]
    , List.map toTodo model.todos |> div []
    , div [] []
    ]

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    AddTodo ->
      let
        currentId = model.nextId
      in
        ({ model
          | todos =  model.todos ++ [ (Todo currentId model.textValue False Nothing) ]
          , textValue = ""
          , nextId = model.nextId + 1
        }, Task.perform (AddDateToTodo currentId) Date.now)

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
    AddDateToTodo id date ->
      let
        changeDate todo =
          if todo.id == id then
            { todo | date = Just date }
          else
           todo
      in
        ({ model | todos = List.map changeDate model.todos }, Cmd.none)

toTodo: Todo -> Html Msg
toTodo value =
  if value.completed == True then
    div []
    [ p [ onClick (ToggleCompleted value.id), style [("text-decoration", "line-through")] ] [text value.description]
    , button [ onClick (DeleteTodo value.id) ] [ text "Delete" ]
    , div [] [ text <| createdAt value.date ]
    ]
  else
    div []
    [ p [ onClick (ToggleCompleted value.id) ] [text value.description]
    , button [ onClick (DeleteTodo value.id) ] [ text "Delete" ]
    , div [] [ text <| createdAt value.date ]
    ]

createdAt: Maybe Date -> String
createdAt date =
  case date of
    Nothing ->
      ""
    Just date ->
      format "Created at: %a %e %b %Y - %k:%M%p" date

subscriptions model =
  Sub.none
