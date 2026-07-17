class Point {
  final double x;
  final double y;

  const Point(this.x, this.y);

  double get norm => x * x + y * y;

  Point operator +(Point other) => Point(x + other.x, y + other.y);
}

class Circle extends Point {
  double radius;
  Circle(super.x, super.y, this.radius);

  @override
  String toString() => 'Circle($x, $y, r=$radius)';
}
