class ArmstrongNumbers {
  bool isArmstrongNumber(String number) {
    return number ==
        number
            .split('')
            .fold(
                BigInt.from(0),
                (previous, element) =>
                    previous + BigInt.parse(element).pow(number.length))
            .toString();
  }
}
