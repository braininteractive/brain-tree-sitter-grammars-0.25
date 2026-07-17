void main() {
  final list = <int>[1, 2, 3];
  final set = {'a', 'b'};
  final map = <String, int>{'one': 1, 'two': 2};

  final doubled = [for (final n in list) n * 2];
  final evens = [
    for (final n in list)
      if (n.isEven) n,
  ];
  final spread = [...list, ...?nullableList()];

  print('$doubled $evens $spread $set ${map.length}');
}

List<int>? nullableList() => null;
