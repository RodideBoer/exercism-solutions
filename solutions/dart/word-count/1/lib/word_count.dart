class WordCount {
  final _punctuation = RegExp(r'\w+', caseSensitive: false);

  Map<String, int> countWords(String sentence) {
    var wordCounts = Map<String, int>();
    RegExp(r"\w+('\w+)?", caseSensitive: false).allMatches(sentence).forEach((match) =>
        wordCounts[match[0]!.toLowerCase()] =
            (wordCounts[match[0]!.toLowerCase()] ?? 0) + 1);
    return wordCounts;
  }
}
