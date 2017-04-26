import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

main =
  beginnerProgram
    { model = model
    , view = view
    , update = update
    }
  
model = 0

view model =
    div []
      [ button [ onClick Decrement ] [ text "-" ]
      , span [ style [("padding", "20px")] ] [ text <| toString model  ]
      , button [ onClick Increment ] [ text "+" ]
      ]
      
type Message = Increment | Decrement

update msg model =
  case msg of 
    Increment ->
      model + 1
    Decrement ->
      model - 1
