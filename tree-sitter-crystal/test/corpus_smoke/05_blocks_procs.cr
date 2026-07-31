nums = [1, 2, 3, 4, 5]
evens = nums.select { |n| n.even? }
doubled = nums.map do |n|
  n * 2
end

adder = ->(a : Int32, b : Int32) { a + b }
puts adder.call(2, 3)

nums.each_with_index do |val, idx|
  puts "#{idx}: #{val}"
end
