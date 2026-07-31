let multi = """
    first line
    "quoted" content
    interpolated \(1 + 2)
    """

let raw = #"raw \n stays, interp \#(40 + 2) works"#
let unicode = "café \u{1F600}"
let dict: [String: [Int]] = ["a": [1, 2], "b": []]
let tuple: (name: String, age: Int) = ("swift", 10)

print(multi, raw, unicode, dict, tuple.name)
