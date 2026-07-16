module example.com/patched

go 1.24

require example.com/upstream v1.2.3

replace example.com/upstream v1.2.3 => example.com/fork v1.2.4

replace (
	example.com/old => example.com/new v2.1.0
	example.com/pinned v0.5.0 => example.com/pinned v0.4.9
)
