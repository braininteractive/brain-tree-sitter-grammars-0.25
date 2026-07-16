module example.com/localdev

go 1.24

require example.com/library v1.0.0

replace example.com/library => ../library

replace (
	example.com/shared v1.1.0 => ./vendor-local/shared
	example.com/tools => ../../shared/tools
)
