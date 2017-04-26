import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

main =
  beginnerProgram
    { model = model
    , view = view
    , update = update
    }

-- Defines alias type
type alias Model = Int
-- Defines union type
type Message = Increment | Decrement

model = 0

view: Model -> Html Message
view model =
    div []
      [ button [ onClick Decrement ] [ text "-" ]
      , span [ style [("padding", "20px")] ] [ text <| toString model  ]
      , button [ onClick Increment ] [ text "+" ]
      ]

update: Message -> Model -> Model
update msg model =
  case msg of 
    Increment ->
      model + 1
    Decrement ->
      model - 1
