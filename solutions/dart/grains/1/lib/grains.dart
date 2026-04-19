import 'dart:math';

BigInt square(final int n) {
  if (n < 1 || n > 64) {
    throw ArgumentError('square must be between 1 and 64');
  }
  return BigInt.from(2).pow(n - 1);
}

BigInt total() {
  return List<BigInt>.generate(64, (n) => BigInt.from(n + 1))
      .reduce((v, e) => v + square(e.toInt()));
}
