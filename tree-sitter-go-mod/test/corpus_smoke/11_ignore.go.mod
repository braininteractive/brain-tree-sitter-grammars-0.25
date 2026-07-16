module example.com/ignoring

go 1.25

ignore ./node_modules

ignore (
	./web/dist
	./testdata/big
)
