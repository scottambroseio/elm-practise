import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- Defines alias type
type alias Model = Int
-- Defines union type
type Message = Increment | Decrement

subscriptions model = 
  Sub.none

init =
  (0, Cmd.none)

view: Model -> Html Message
view model =
    div []
      [ button [ onClick Decrement ] [ text "-" ]
      , span [ style [("padding", "20px")] ] [ text <| toString model  ]
      , button [ onClick Increment ] [ text "+" ]
      ]

update: Message -> Model -> (Model, Cmd Message)
update msg model =
  case msg of 
    Increment ->
      (model + 1, Cmd.none)
    Decrement ->
      (model - 1, Cmd.none)
