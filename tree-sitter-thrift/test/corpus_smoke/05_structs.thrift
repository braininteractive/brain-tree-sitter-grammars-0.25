// Structs with field ids, requiredness, and defaults.
struct Point {
  1: required double x;
  2: required double y;
  3: optional double z = 0.0;
}

struct User {
  1: required string name,
  2: optional i32 age = 21,
  3: required bool active = true,
  4: optional binary avatar,
}

struct Nested {
  1: required Point origin;
  2: optional User owner;
}
