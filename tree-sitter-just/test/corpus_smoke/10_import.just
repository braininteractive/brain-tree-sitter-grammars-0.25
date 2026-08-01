export RUST_LOG := "debug"

import "shared.just"

run *ARGS:
    cargo run -- {{ARGS}}
