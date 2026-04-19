class Bob {
  String response(String input) {
    if (input.isSilence()) {
      return 'Fine. Be that way!';
    }
    if (input.isScreaming() && input.isAsking()) {
      return 'Calm down, I know what I\'m doing!';
    }
    if (input.isScreaming()) {
      return 'Whoa, chill out!';
    }
    if (input.isAsking()) {
      return 'Sure.';
    }
    return 'Whatever.';
  }

  // Old way without extension methods
  // bool _isAsking(String input) => input.endsWith('?');
  //
  // bool _isScreaming(String input) =>
  //     input.toUpperCase() == input && RegExp(r'[A-Za-z]').hasMatch(input);
  //
  // bool _isSilence(String input) => RegExp(r'^\s*$').hasMatch(input);
}

extension WayOfTalking on String {
  bool isAsking() => this.trim().endsWith('?');

  bool isScreaming() =>
      this == this.toUpperCase() && this != this.toLowerCase();

  bool isSilence() => this.trim().isEmpty;
}
