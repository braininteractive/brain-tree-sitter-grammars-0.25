import Foundation

func fetchData(id: Int) async throws -> String {
    try await Task.sleep(nanoseconds: 1_000_000)
    return "data\(id)"
}

func loadAll() async throws -> [String] {
    async let a = fetchData(id: 1)
    async let b = fetchData(id: 2)
    return try await [a, b]
}

actor Counter {
    private var value = 0

    func increment() -> Int {
        value += 1
        return value
    }
}
