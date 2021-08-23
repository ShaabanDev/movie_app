class MovieDetails {
  final String id;
  final String title;
  final String posterPath;
  final String releaseDate;
  final String overview;
  final double voteAverage;
  final String status;

  MovieDetails(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.releaseDate,
      required this.overview,
      required this.voteAverage,
      required this.status});
}
