enum Status {
  active(1),
  inactive(0);

  final int code;
  const Status(this.code);

  bool get isActive => this == Status.active;
}

extension StringX on String {
  String get reversed => split('').reversed.join();
  int toIntOr(int fallback) => int.tryParse(this) ?? fallback;
}

void main() {
  print(Status.active.code);
  print('abc'.reversed);
}
