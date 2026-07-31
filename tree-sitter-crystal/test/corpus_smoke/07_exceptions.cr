class ParseError < Exception
end

def parse_age(s : String) : Int32
  s.to_i
rescue ArgumentError
  raise ParseError.new("bad age: #{s}")
ensure
  puts "attempted"
end

begin
  parse_age("abc")
rescue e : ParseError
  puts e.message
end
