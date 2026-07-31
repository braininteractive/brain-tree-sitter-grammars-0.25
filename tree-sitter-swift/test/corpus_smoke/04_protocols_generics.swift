protocol Repository {
    associatedtype Entity
    func find(id: Int) -> Entity?
    func save(_ entity: Entity)
}

struct InMemoryRepo<T>: Repository {
    private var store: [Int: T] = [:]

    func find(id: Int) -> T? { store[id] }

    mutating func save(_ entity: T) {
        store[store.count] = entity
    }
}

func biggest<T: Comparable>(_ a: T, _ b: T) -> T {
    a > b ? a : b
}
