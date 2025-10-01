double convertVoteAverage(double voteAverage) {
  if (voteAverage < 0.0) {
    voteAverage = 0.0;
  } else if (voteAverage > 10.0) {
    voteAverage = 10.0;
  }

  final percent = voteAverage / 10.0;
  return percent;
}
