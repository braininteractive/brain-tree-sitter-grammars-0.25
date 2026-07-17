import 'dart:async';

Future<String> fetchData(int id) async {
  await Future.delayed(const Duration(milliseconds: 10));
  return 'data$id';
}

Stream<int> countTo(int n) async* {
  for (var i = 1; i <= n; i++) {
    yield i;
  }
}

Future<void> main() async {
  final results = await Future.wait([fetchData(1), fetchData(2)]);
  print(results);
  await for (final n in countTo(3)) {
    print(n);
  }
}
