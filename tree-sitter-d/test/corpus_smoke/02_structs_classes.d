struct Point
{
    double x;
    double y;

    double norm() const
    {
        import std.math : sqrt;
        return sqrt(x * x + y * y);
    }
}

class Shape
{
    abstract double area() const;
}

class Circle : Shape
{
    private double radius;

    this(double r) { radius = r; }

    override double area() const
    {
        return 3.14159 * radius * radius;
    }
}
