int divide(int a, int b)
in (b != 0, "denominator must be nonzero")
out (r; r * b <= a)
{
    return a / b;
}

invariant_demo: unittest
{
    assert(divide(10, 2) == 5);
}

struct Positive
{
    int value;

    invariant
    {
        assert(value > 0);
    }
}
