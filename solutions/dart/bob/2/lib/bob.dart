class Bob {
  String response(String input) {
    if (_isSilence(input)) {
      return 'Fine. Be that way!';
    }
    input = input.trim();
    if (_isScreaming(input) && input.isAsking()) {
      return 'Calm down, I know what I\'m doing!';
    }
    if (_isScreaming(input)) {
      return 'Whoa, chill out!';
    }
    if (input.isAsking()) {
      return 'Sure.';
    }
    return 'Whatever.';
  }

  bool _isAsking(String input) => input.endsWith('?');

  bool _isScreaming(String input) =>
      input.toUpperCase() == input && RegExp(r'[A-Za-z]').hasMatch(input);

  bool _isSilence(String input) =>RegExp(r'^\s*$').hasMatch(input);
}

extension WayOfTalking on String {
  bool isAsking() => this.endsWith('?');
}
