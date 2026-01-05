/// Represents a credit (movie or TV series) associated with an actor
/// Used to display movies and TV shows that an actor has appeared in
class Credit {
  /// Unique identifier for the credit
  int id;
  /// Title of the movie or name of the TV series
  String title;
  /// URL path to the poster image
  String posterPath;
  /// URL path to the backdrop image
  String backdropPath;
  /// Plot summary/description
  String overview;
  /// Release date of the movie or first air date of the series
  String releaseDate;
  /// Average vote/rating score from users
  double voteAverage;
  /// Type of media: either "movie" or "tv"
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