import Html
import List
import Tuple
    
main =
  --listfn [1,2,3,4,5]
  --tuplefn (True, 1, "2")
  --distanceBetween { x=1, y=2 } { x=5, y=6 }

distanceBetween p1 p2 =
  ((p1.x - p2.x) ^ 2 + (p1.y + p2.y) ^ 2) ^ 0.5
    |> toString
      |> Html.text

listfn list =
  list
    |> List.reverse
      |> toString
        |> Html.text

tuplefn tuple = 
  tuple
    |> toString
      |> Html.text
