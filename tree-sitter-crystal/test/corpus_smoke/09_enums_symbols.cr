enum Color : UInt8
  Red   = 1
  Green
  Blue

  def warm?
    self == Color::Red
  end
end

c = Color::Green
puts c.value
state = :running
puts state == :running
