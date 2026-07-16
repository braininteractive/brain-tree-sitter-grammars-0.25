-- Lambdas, function types, forall, and application.
let double = \(n : Natural) -> n * 2

let compose
    : forall (a : Type) -> forall (b : Type) -> forall (c : Type) ->
        (a -> b) -> (b -> c) -> a -> c
    = \(a : Type) ->
      \(b : Type) ->
      \(c : Type) ->
      \(f : a -> b) ->
      \(g : b -> c) ->
      \(x : a) ->
        g (f x)

let quadruple = compose Natural Natural Natural double double

in  { eight = quadruple 2, four = double 2 }
