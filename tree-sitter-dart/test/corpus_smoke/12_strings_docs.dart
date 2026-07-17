/// Documentation comment for [describe].
///
/// Supports `code spans` and *emphasis*.
String describe(String name, int count) {
  final single = 'single $name';
  final double_ = "double ${count + 1}";
  final raw = r'raw \n not escaped';
  final multi = '''
multi
line $name
''';
  return '$single $double_ $raw $multi';
}

// Regular comment.
void main() => print(describe('x', 1));
