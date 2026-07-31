enum factorial(int n) = n <= 1 ? 1 : n * factorial!(n - 1);

string makeGetter(string name)()
{
    return "int get_" ~ name ~ "() { return " ~ name ~ "; }";
}

struct Config
{
    int width = 800;
    mixin(makeGetter!"width");
}

static assert(factorial!5 == 120);
