def classify(n : Int32) : String
  if n < 0
    "negative"
  elsif n == 0
    "zero"
  else
    "positive"
  end
end

x = 5
while x > 0
  x -= 1
end

until x >= 3
  x += 1
end

case classify(3)
when "positive" then puts "yes"
when "negative", "zero" then puts "no"
else puts "?"
end
