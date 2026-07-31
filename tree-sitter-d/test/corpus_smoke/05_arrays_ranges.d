import std.algorithm : filter, map, sum;
import std.range : iota;

void demo()
{
    int[] dynamic = [1, 2, 3];
    int[3] fixedArr = [4, 5, 6];
    int[string] assoc = ["one": 1, "two": 2];

    auto slice = dynamic[0 .. 2];
    dynamic ~= 4;

    auto result = iota(1, 100)
        .filter!(n => n % 3 == 0)
        .map!(n => n * n)
        .sum;
}
