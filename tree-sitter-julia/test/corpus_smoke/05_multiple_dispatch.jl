struct Cat end
struct Dog end

speak(::Cat) = "meow"
speak(::Dog) = "woof"
speak(a, b) = speak(a) * " " * speak(b)

interact(x::T, y::T) where {T} = "same species: $(speak(x))"
interact(x, y) = speak(x, y)

println(interact(Cat(), Cat()))
println(interact(Cat(), Dog()))
