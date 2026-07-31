void strings()
{
    string plain = "escapes: \t \n";
    wstring wide = "wide"w;
    dstring dstr = "dchar"d;
    string wysiwyg = r"C:\raw\path";
    string backtick = `also raw "quotes"`;
    string delimited = q{ int embedded = 1; };
    char c = 'x';

    immutable interpLike = plain ~ wysiwyg;
    scope (exit)
    {
    }
}
