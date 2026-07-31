string classify(int n)
{
    if (n < 0)
        return "negative";
    else if (n == 0)
        return "zero";

    foreach (i; 0 .. 10)
    {
        if (i == 5)
            break;
    }

    int j = 3;
    while (j > 0)
        j--;

    do
        j++;
    while (j < 2);

    switch (n)
    {
    case 1: .. case 9:
        return "digit";
    default:
        return "big";
    }
}
