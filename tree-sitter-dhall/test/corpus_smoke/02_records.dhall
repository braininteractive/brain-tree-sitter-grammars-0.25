-- Record literals, record types, nested records, field selection, projection.
let Config
    : Type
    = { host : Text, port : Natural, tls : Bool }

let config
    : Config
    = { host = "localhost", port = 8080, tls = False }

let nested = { server = { inner = config }, meta = { version = "1.0" } }

in  { port = config.port
    , host = nested.server.inner.host
    , picked = config.{ host, port }
    , empty = {=}
    }
