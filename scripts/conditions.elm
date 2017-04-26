import Html

main =
  isEven 10
  |> toString
    |>
      Html.text

-- Function signature
isEven: Int -> Bool
-- Function implementation
isEven num =
  if rem num 2 == 0 then
    True
  else
    False
