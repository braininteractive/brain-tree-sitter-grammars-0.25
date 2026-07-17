String classify(int n) {
  if (n < 0) {
    return 'negative';
  } else if (n == 0) {
    return 'zero';
  }
  var acc = 0;
  for (var i = 0; i < n; i++) {
    acc += i;
  }
  while (acc > 100) {
    acc ~/= 2;
  }
  do {
    acc--;
  } while (acc > 50);
  switch (n % 3) {
    case 0:
      return 'fizz';
    case 1:
      return 'one $acc';
    default:
      return 'other';
  }
}
