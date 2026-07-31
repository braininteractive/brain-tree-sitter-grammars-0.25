class ValidationException : Exception
{
    this(string msg, string file = __FILE__, size_t line = __LINE__)
    {
        super(msg, file, line);
    }
}

int parseAge(string s)
{
    import std.conv : to, ConvException;

    try
    {
        immutable age = s.to!int;
        if (age < 0)
            throw new ValidationException("negative age");
        return age;
    }
    catch (ConvException e)
    {
        return -1;
    }
    finally
    {
    }
}
