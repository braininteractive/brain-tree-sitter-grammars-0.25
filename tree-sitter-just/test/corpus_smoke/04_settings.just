# comment on top
set shell := ["bash", "-cu"]
set dotenv-load

lint:
    # recipe comment
    cargo clippy
