def find(haystack : Array(String), needle : String) : Int32?
  haystack.each_with_index do |item, i|
    return i if item == needle
  end
  nil
end

value : Int32 | String = 42
value = "now a string"

if idx = find(["a", "b"], "b")
  puts idx
end

name = nil
puts name.try &.upcase
