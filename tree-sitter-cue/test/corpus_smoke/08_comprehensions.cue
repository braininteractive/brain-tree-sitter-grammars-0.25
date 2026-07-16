package hello

items: ["a", "b", "c"]

listComp: [for x in items {x}]
withIndex: [for i, x in items {"\(i)-\(x)"}]
filtered: [for x in items if x != "b" {x}]

structComp: {
	for k, v in {a: 1, b: 2} {
		"key_\(k)": v * 10
	}
}

matrix: [for x in [1, 2] for y in [3, 4] {x * y}]
