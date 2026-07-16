// Array comprehensions, nested for specs, and filters.
local numbers = [1, 2, 3, 4, 5];

{
  squares: [n * n for n in numbers],
  evens: [n for n in numbers if n % 2 == 0],
  pairs: [[a, b] for a in [1, 2] for b in ["x", "y"]],
  flattened: [x for row in [[1, 2], [3, 4]] for x in row],
}
