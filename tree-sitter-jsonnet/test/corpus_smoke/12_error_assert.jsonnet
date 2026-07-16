// assert statements (top-level and in objects) and error expressions.
local positive(n) =
  assert n > 0 : "expected a positive number, got %d" % n;
  n;

local checked = {
  assert self.min <= self.max : "min must not exceed max",
  min: 1,
  max: 10,
};

assert std.length("abc") == 3;

{
  value: positive(5),
  range: checked,
  fail_path: if false then error "unreachable" else "ok",
}
