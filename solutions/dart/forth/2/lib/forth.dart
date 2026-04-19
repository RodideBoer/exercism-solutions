class Forth {
  final stack = <int>[];
  final _customWords = Map<String, String>();

  void evaluate(String words) {
    if (_isCustomWordDefinition(words)) {
      _createCustomWord(words);
      return;
    }
    for (var word in words.split(' ')) {
      _evaluateWord(word.toLowerCase());
    }
  }

  void _evaluateWord(String word) {
    if (_isStackable(word)) {
      stack.add(int.parse(word));
      return;
    }
    if (_isCustomWord(word)) {
      _evaluateCustomWord(word);
      return;
    }

    _executeWord(word);
  }

  void _executeWord(String word) {
    switch (word) {
      case '+':
        _assertParams(2);
        stack.add(_pop(2) + _pop());
      case '-':
        _assertParams(2);
        stack.add(_pop(2) - _pop());
      case '*':
        _assertParams(2);
        stack.add(_pop(2) * _pop());
      case '/':
        _assertParams(2);
        final div = _pop();
        if (div == 0) {
          throw Exception('Division by zero');
        }
        stack.add(_pop() ~/ div);
      case 'dup':
        _assertParams(1);
        stack.add(stack.last);
      case 'drop':
        _assertParams(1);
        stack.removeLast();
      case 'swap':
        _assertParams(2);
        stack.add(_pop(2));
      case 'over':
        _assertParams(2);
        stack.add(stack[stack.length-2]);
      default:
        throw Exception('Unknown command');
    }
  }

  void _evaluateCustomWord(String word) {
    if (_customWords[word] == null) {
      return;
    }
    evaluate(_customWords[word]!);
  }

  bool _isCustomWordDefinition(String words) =>
      words.startsWith(': ') && words.endsWith(' ;');

  void _createCustomWord(String words) {
    var definition = words.substring(1, words.length-2).trim().split(' ');
    if (definition.length < 2) {
      throw Exception('Invalid definition');
    }
    var wordName = definition.removeAt(0).toLowerCase();
    var number = int.tryParse(wordName);
    if (number != null) {
      throw Exception('Invalid definition');
    }
    _customWords[wordName] = List.from(definition.map(
        (e) => _customWords.containsKey(e) ? _customWords[e] : e)).join(' ');
  }

  void _assertParams(int n) {
    if (stack.length < n) {
      throw Exception('Stack empty');
    }
  }

  int _pop([int n = 1]) => stack.removeAt(stack.length-n);

  bool _isStackable(String word) => int.tryParse(word) != null;

  bool _isCustomWord(String word) => _customWords.containsKey(word);
}
