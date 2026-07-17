class ValidationError implements Exception {
  final String message;
  ValidationError(this.message);
}

int parseAge(String input) {
  try {
    final age = int.parse(input);
    if (age < 0) throw ValidationError('negative age');
    return age;
  } on FormatException catch (e) {
    print('bad format: ${e.message}');
    rethrow;
  } catch (e, stack) {
    print('$e\n$stack');
    return -1;
  } finally {
    print('parse attempted');
  }
}
