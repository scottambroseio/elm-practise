import Html exposing (..)
import Html.Attributes exposing (style)

main =
  div []
    [ button [] [ text "-" ]
    , span [ style [("padding", "20px")] ] [ text "0"]
    , button [] [ text "+" ]
    ]
  
