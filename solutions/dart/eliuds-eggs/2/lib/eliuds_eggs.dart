class EggCounter {
  int count(int code) {
    var eggs = 0;
    while(code > 0) {
      if (code & 1 == 1) {
        eggs++;
      }
      code >>= 1;
    }
    return eggs;
  }
}
