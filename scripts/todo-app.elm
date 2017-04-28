import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Date exposing (Date)
import List
import Task

main: Program Never Model Message
main =
  program { init = init, update = update, view = view, subscriptions = subscriptions }

type alias Todo =
  { id: Int
  , description: String
  , isCompleted: Bool
  , createdAt: Maybe Date
  }

type alias Model =
  { nextId: Int
  , todos: List Todo
  , inputValue: String
  }

type Message
  = CreateTodo
  | DeleteTodo Int
  | ToggleCompletedTodo Int
  | OnInputValue String
  | ReceiveCurrentDate Int Date

init: (Model, Cmd Message)
init =
  ((Model 0 [] ""), Cmd.none)

view: Model -> Html Message
view model =
  div []
  [ h1 [] [ text "Todo App" ]
  , div []
    [ input [ type_ "text", value model.inputValue, onInput OnInputValue ] []
    , button [ onClick CreateTodo ] [ text "Add Todo" ]
    ]
  , div [] [ todoList model ]
  ]

getCurrentDate: Int -> Cmd Message
getCurrentDate id =
  Task.perform (ReceiveCurrentDate id) Date.now

todoList: Model -> Html Message
todoList model =
  List.map mapTodoToLi model.todos |> ul []

todoStyles: Todo -> Attribute Message
todoStyles todo =
  case todo.isCompleted of
    True ->
      style [ ("text-decoration", "line-through") ]
    False ->
      style []

mapTodoToLi: Todo -> Html Message
mapTodoToLi todo =
  li []
    [ div [ todoStyles todo, onClick <| ToggleCompletedTodo todo.id ] [ text todo.description ]
    , button [ onClick <| DeleteTodo todo.id ] [ text "Delete" ]
    ]

newTodo: Model -> Todo
newTodo model =
  Todo model.nextId model.inputValue False Nothing

update: Message -> Model -> (Model, Cmd Message)
update msg model =
  case msg of
    OnInputValue value ->
      ({ model | inputValue = value }, Cmd.none)
    CreateTodo ->
      let
        id = model.nextId
        todos = newTodo model :: model.todos
      in
      ({ model | inputValue = "", todos = todos, nextId = id + 1 }, getCurrentDate id)
    DeleteTodo id ->
      let
        todos = List.filter (\t -> t.id /= id) model.todos
      in
        ({ model | todos = todos }, Cmd.none)
    ToggleCompletedTodo id ->
      let
        todos = List.map (\t -> if t.id == id then { t | isCompleted = not t.isCompleted } else t ) model.todos
      in
        ({ model | todos = todos }, Cmd.none)
    ReceiveCurrentDate id date ->
      let
        todos = List.map (\t -> if t.id == id then { t | createdAt = Just date } else t ) model.todos
      in
        ({ model | todos = todos }, Cmd.none)

subscriptions: Model -> Sub Message
subscriptions model =
  Sub.none
