// Calls into the std library.
local words = ["one", "two", "three"];

{
  joined: std.join(", ", words),
  upper: std.asciiUpper("shout"),
  length: std.length(words),
  mapped: std.map(function(w) std.length(w), words),
  sorted: std.sort([3, 1, 2]),
  object: std.objectFields({ a: 1, b: 2 }),
  formatted: std.format("%s has %d items", ["list", 3]),
}
