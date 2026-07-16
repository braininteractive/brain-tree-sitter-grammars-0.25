// Deprecated: use example.com/hello/v2 instead.
module example.com/hello

// The minimum supported Go release.
go 1.22 // keep in sync with CI

// Direct dependencies only; run `go mod tidy` after editing.
require (
	// structured logging
	example.com/logging v1.4.2
	example.com/router v0.9.1 // HTTP router
)
