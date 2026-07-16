" Expressions: ternaries, concatenation, lambdas and method calls.
let s:mode = &readonly ? 'read-only' : 'editable'
let s:greeting = 'hello' . ', ' . 'world'
let s:Double = {x -> x * 2}
let s:Add = {a, b -> a + b}
let s:evens = filter(range(10), {_, v -> v % 2 == 0})
let s:names = ['ana', 'bob', 'eve']
let s:upper = s:names->map({_, v -> toupper(v)})->filter({_, v -> v =~# '^A'})
let s:len = s:greeting->strlen()
echo s:Add(s:Double(3), 4)
