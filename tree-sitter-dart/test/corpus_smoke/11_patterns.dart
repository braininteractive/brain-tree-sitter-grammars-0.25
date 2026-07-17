sealed class Shape {}

class Square extends Shape {
  final double side;
  Square(this.side);
}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);
}

double area(Shape shape) => switch (shape) {
      Square(side: final s) => s * s,
      Circle(radius: final r) => 3.14159 * r * r,
    };

void main() {
  final (a, b) = (1, 2);
  final [first, ...rest] = [1, 2, 3];
  print('$a $b $first $rest');
  print(area(Square(2)));
}
