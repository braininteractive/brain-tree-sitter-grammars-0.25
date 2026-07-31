module Comparable(T)
  abstract def <=>(other : T)
end

class Stack(T)
  def initialize
    @items = [] of T
  end

  def push(item : T)
    @items << item
  end

  def pop : T?
    @items.pop?
  end
end

s = Stack(Int32).new
s.push(1)
