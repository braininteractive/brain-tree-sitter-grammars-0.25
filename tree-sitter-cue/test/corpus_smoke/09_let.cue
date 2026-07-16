package hello

let base = 10
let scale = 2.5

result: base * scale

out: {
	let tmp = base + 1
	value: tmp
}

squares: [
	for x in [1, 2, 3]
	let sq = x * x {
		sq
	},
]
