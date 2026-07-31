import std.functional : pipe;

alias Adder = int delegate(int);

Adder makeAdder(int base)
{
    return (int x) => base + x;
}

void higher(int function(int) f, int delegate(int) d)
{
    auto lambda = (int a, int b) { return a * b; };
    cast(void) lambda(2, 3);
}

pure nothrow @safe @nogc int squared(int x)
{
    return x * x;
}
