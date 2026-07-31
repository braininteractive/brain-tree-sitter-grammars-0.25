@[Link("m")]
lib LibM
  fun sqrt(x : Float64) : Float64
end

annotation MyAnn
end

@[MyAnn]
def documented
  LibM.sqrt(4.0)
end

puts documented
