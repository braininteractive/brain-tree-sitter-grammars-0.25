{- A block comment: this file mixes assert, with, completion,
   and builtins for broader coverage. -}
let Config = { host : Text, port : Natural }

let default
    : Config
    = { host = "localhost", port = 80 }

let Schema = { Type = Config, default }

let completed = Schema::{ port = 8080 }

let updated = default with port = 443 with host = "example.com"

let check = assert : 1 + 1 === 2

let shown = Natural/show (Natural/fold 3 Natural (\(n : Natural) -> n + 1) 0)

in  { completed, updated, shown }
