class WordCount {
  Map<String, int> countWords(String sentence) {
    var wordCounts = Map<String, int>();
    RegExp(r"\w+('\w+)?", caseSensitive: false).allMatches(sentence).forEach(
        (match) => wordCounts.update(
            match[0]!.toLowerCase(),
            (v) => ++v,
            ifAbsent: () => 1,
        ));
    return wordCounts;
  }
}
