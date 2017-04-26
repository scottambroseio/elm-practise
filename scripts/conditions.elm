import Html

main =
  isEven 10
    |> toString
    |> Html.text
  
isEven: Int -> Bool
isEven num =
  if rem num 2 == 0 then
    True
  else
    False
