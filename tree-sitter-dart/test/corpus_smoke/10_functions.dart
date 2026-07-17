typedef IntOp = int Function(int, int);

int apply(IntOp op, int a, int b) => op(a, b);

void main() {
  final add = (int a, int b) => a + b;
  int mul(int a, int b) => a * b;

  print(apply(add, 2, 3));
  print(apply(mul, 2, 3));

  void greet({required String name, String greeting = 'hi'}) {
    print('$greeting $name');
  }

  greet(name: 'dart');

  int sum(int first, [int second = 0]) => first + second;
  print(sum(1, 2));
}
