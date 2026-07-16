-- Optional values: Some, None, and Optional types.
let someValue
    : Optional Natural
    = Some 5

let noValue
    : Optional Natural
    = None Natural

let nestedOptional
    : Optional (Optional Text)
    = Some (Some "present")

let describe =
      \(o : Optional Natural) ->
        merge { Some = \(n : Natural) -> "got a value", None = "nothing" } o

in  { someValue, noValue, nestedOptional, described = describe someValue }
