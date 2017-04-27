import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

main =
  beginnerProgram
    { model = model
    , view = view
    , update = update
    }

type alias Model =
  { current: Int
  , step: Int
  }

type Message
  = Increment
  | Decrement

model =
  { current = 0
  , step = 5
  }

view: Model -> Html Message
view model =
    div []
      [ button [ onClick Decrement ] [ text "-" ]
      , span [ style [("padding", "20px")] ] [ text <| toString model.current ]
      , button [ onClick Increment ] [ text "+" ]
      ]

update: Message -> Model -> Model
update msg model =
  case msg of
    Increment ->
      { model | current = model.current + model.step }
    Decrement ->
      { model | current = model.current - model.step }
