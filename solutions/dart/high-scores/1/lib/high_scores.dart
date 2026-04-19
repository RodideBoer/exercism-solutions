class HighScores {
  final List<int> scores;

  HighScores(this.scores);

  int latest() {
    return scores.last;
  }

  int personalBest() {
    return scores
        .reduce((int value, int element) => element > value ? element : value);
  }

  Iterable<int> personalTopThree() {
    var temp = List<int>.from(scores);
    temp.sort();
    return temp.reversed.take(3);
  }
}
