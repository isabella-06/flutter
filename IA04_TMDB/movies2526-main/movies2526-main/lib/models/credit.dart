/// Represents a credit (movie or TV series) associated with an actor
/// Used to display movies and TV shows that an actor has appeared in
class Credit {
  int id;
  String title;
  String posterPath;
  String backdropPath;
  String overview;
  String releaseDate;
  double voteAverage;

  String mediaType;

  Credit({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.mediaType,
  });

  /// Creates a Credit instance from a JSON map
  /// Handles both movie and TV series fields (title/name, release_date/first_air_date)
  factory Credit.fromMap(Map<String, dynamic> map) {
    return Credit(
      id: map['id'] as int,
      title: map['title'] ?? map['name'] ?? 'Unknown Title',
      posterPath: map['poster_path'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
      overview: map['overview'] ?? '',
      releaseDate: map['release_date'] ?? map['first_air_date'] ?? '',
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      mediaType: map['media_type'] ?? 'movie',
    );
  }
}