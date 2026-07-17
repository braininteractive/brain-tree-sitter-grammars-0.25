String? findName(Map<String, String> data, String key) {
  return data[key];
}

void use() {
  final name = findName({'a': 'alice'}, 'a');
  final length = name?.length ?? 0;
  final forced = name!;
  print('$length $forced');

  late String computed;
  computed = 'later';
  print(computed);
}
