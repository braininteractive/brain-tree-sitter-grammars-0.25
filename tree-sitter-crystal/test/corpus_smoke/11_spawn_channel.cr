channel = Channel(Int32).new

3.times do |i|
  spawn do
    channel.send(i * 10)
  end
end

3.times do
  puts channel.receive
end
