// String formatting via the % operator (jsonnet's interpolation idiom).
local name = "world";
local items = 4;

{
  simple: "hello %s" % name,
  multi: "%s has %d entries" % [name, items],
  keyed: "%(who)s scored %(points)03d" % { who: "team", points: 7 },
  percent: "100%% done" % [],
  block: |||
    a text block
    spanning lines
  |||,
}
