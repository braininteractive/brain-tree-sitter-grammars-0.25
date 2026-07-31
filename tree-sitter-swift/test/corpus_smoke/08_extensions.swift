extension String {
    var reversedWords: String {
        split(separator: " ").reversed().joined(separator: " ")
    }

    func padded(to length: Int) -> String {
        padding(toLength: length, withPad: " ", startingAt: 0)
    }
}

extension Collection where Element: Numeric {
    var total: Element {
        reduce(0, +)
    }
}

print("hello world".reversedWords, [1, 2, 3].total)
