// Named and anonymous functions, default params, named arguments.
local add(a, b) = a + b;
local greet(name, punctuation="!") = "hello " + name + punctuation;
local twice = function(x) x * 2;

{
  sum: add(1, 2),
  hi: greet("world"),
  loud: greet("world", punctuation="!!"),
  four: twice(2),
  apply: (function(f, v) f(v))(twice, 10),
}
