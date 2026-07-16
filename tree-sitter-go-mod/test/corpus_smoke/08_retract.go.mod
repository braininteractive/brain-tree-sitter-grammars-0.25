module example.com/retractor

go 1.24

retract v1.0.1 // published accidentally

retract (
	v1.1.0 // contains a data-loss bug
	[v1.2.0, v1.2.5] // built with the wrong toolchain
)
