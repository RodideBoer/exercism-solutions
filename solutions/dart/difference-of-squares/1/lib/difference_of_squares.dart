class DifferenceOfSquares {
  int square(int input) => input * input;

  List<int> _toList(int input) => [for (int i = 1; i <= input; i++) i];

  int squareOfSum(int input) {
    return square(
      _toList(input).fold(0, (previous, element) => previous + element),
    );
  }

  int sumOfSquares(int input) {
    return _toList(input).reduce((value, element) => value + square(element));
  }

  int differenceOfSquares(int input) {
    return (sumOfSquares(input) - squareOfSum(input)).abs();
  }
}
