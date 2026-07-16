module example.com/careful

go 1.23

require example.com/dep v1.5.0

exclude example.com/dep v1.4.0

exclude (
	example.com/dep v1.3.0
	example.com/other v0.2.0
)
