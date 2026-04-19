import 'dart:math';

class AtbashCipher {
  final a = 'a'.codeUnitAt(0);
  final z = 'z'.codeUnitAt(0);
  final d1 = '1'.codeUnitAt(0);
  final d9 = '9'.codeUnitAt(0);

  String encode(String input) {
    return String.fromCharCodes(
      input
          .replaceAll(
            RegExp(r'\W'),
            '',
          )
          .toLowerCase()
          .codeUnits
          .map(
            atbashMap,
          ),
    ).splitLen(5).join(' ');
  }

  String decode(String input) {
    return String.fromCharCodes(
      input
          .replaceAll(
            RegExp(r'\s'),
            '',
          )
          .codeUnits
          .map(
            atbashMap,
          ),
    );
  }

  int atbashMap(int e) {
    if (e < d1 || e > d9) {
      return z - e + a;
    }
    return e;
  }
}

extension StringSplitting on String {
  List<String> splitLen(int length) {
    List<String> parts = [];
    var currentString = this;
    while (currentString.length > 0) {
      var l = min(currentString.length, length);
      parts.add(currentString.substring(0, l));
      currentString = currentString.substring(l);
    }
    return parts;
  }
}
