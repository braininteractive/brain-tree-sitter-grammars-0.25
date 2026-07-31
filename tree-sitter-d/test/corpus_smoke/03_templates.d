T biggest(T)(T a, T b)
{
    return a > b ? a : b;
}

struct Stack(T)
{
    private T[] items;

    void push(T item) { items ~= item; }

    T pop()
    {
        auto top = items[$ - 1];
        items = items[0 .. $ - 1];
        return top;
    }
}

enum isNumeric(T) = is(T : long) || is(T : real);

void constrained(T)(T value) if (isNumeric!T)
{
}
