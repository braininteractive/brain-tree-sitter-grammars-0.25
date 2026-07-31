enum ValidationError: Error {
    case tooShort(min: Int)
    case invalidCharacter(Character)
}

func validate(_ password: String) throws {
    if password.count < 8 {
        throw ValidationError.tooShort(min: 8)
    }
}

do {
    try validate("abc")
} catch ValidationError.tooShort(let min) {
    print("need \(min) characters")
} catch {
    print("other: \(error)")
}

let result = try? validate("longenough")
print(result as Any)
