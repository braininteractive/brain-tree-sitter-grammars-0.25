@resultBuilder
enum ListBuilder {
    static func buildBlock(_ parts: String...) -> [String] {
        Array(parts)
    }

    static func buildOptional(_ part: [String]?) -> [String] {
        part ?? []
    }
}

func makeList(@ListBuilder _ content: () -> [String]) -> [String] {
    content()
}

let items = makeList {
    "alpha"
    "beta"
}

print(items)
