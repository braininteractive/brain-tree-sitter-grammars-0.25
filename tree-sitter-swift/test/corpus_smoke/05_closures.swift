let nums = [1, 2, 3, 4, 5]
let evens = nums.filter { $0 % 2 == 0 }
let doubled = nums.map { n in n * 2 }
let total = nums.reduce(0, +)

let adder: (Int, Int) -> Int = { a, b in a + b }

func retry(times: Int, task: () throws -> Void) rethrows {
    for _ in 0..<times {
        try task()
    }
}

print(evens, doubled, total, adder(1, 2))
