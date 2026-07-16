module example.com/tooling

go 1.24

tool example.com/tools/cmd/lint

tool (
	example.com/tools/cmd/generate
	golang.org/x/tools/cmd/stringer
)

require example.com/tools v0.8.0
