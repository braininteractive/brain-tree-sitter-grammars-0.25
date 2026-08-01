[private]
helper:
    echo internal

[group("ci")]
ci: lint test
    echo done

alias b := build

build:
    make
lint:
    true
test:
    true
