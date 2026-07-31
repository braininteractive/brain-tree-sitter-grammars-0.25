func find(_ haystack: [String], _ needle: String) -> Int? {
    for (i, item) in haystack.enumerated() where item == needle {
        return i
    }
    return nil
}

if let idx = find(["a", "b"], "b") {
    print(idx)
}

guard let first = ["x"].first else {
    fatalError("empty")
}

let name: String? = nil
let display = name ?? "anonymous"
let forced = display
print(first, forced)
