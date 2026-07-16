-- Union types, constructors, and merge.
let Status = < Running | Stopped | Failed : Text >

let current = Status.Running

let describe =
      \(s : Status) ->
        merge
          { Running = "up"
          , Stopped = "down"
          , Failed = \(msg : Text) -> "failed: ${msg}"
          }
          s

in  { now = describe current
    , bad = describe (Status.Failed "disk full")
    }
