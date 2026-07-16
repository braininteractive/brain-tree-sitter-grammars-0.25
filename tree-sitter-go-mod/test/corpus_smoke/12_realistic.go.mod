module example.com/service/api

go 1.24.1

toolchain go1.24.4

require (
	example.com/auth v2.3.1+incompatible
	example.com/metrics v0.0.0-20240102150405-abcdef123456
	example.com/queue v1.7.0
)

require (
	example.com/internal/util v0.1.0 // indirect
	golang.org/x/sync v0.7.0 // indirect
)

replace example.com/queue => example.com/queue-fork v1.7.1

exclude example.com/metrics v0.0.0-20231225000000-fedcba654321

retract [v0.1.0, v0.1.9] // pre-release versions, do not use
