class EggCounter {
  int count(int code) {
    var temp = code;
    var eggs = 0;
    for (var i = code.bitLength+1; i >= 0; i--) {
      var exp = 1<<i;
      if (temp - exp < 0) {
        continue;
      }
      eggs++;
      temp -= exp;
    }
    return eggs;
  }
}
