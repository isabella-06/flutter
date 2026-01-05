import 'dart:convert';

/// Represents a movie object with details fetched from TMDB API
class Movie {
  /// Unique identifier for the movie
  int id;
  /// Title of the movie
  String title;
  /// URL path to the movie poster image
  String posterPath;
  /// URL path to the movie backdrop image
  String backdropPath;
  /// Plot summary/description of the movie
  String overview;
  /// Release date of the movie
  String releaseDate;
  /// Average vote/rating score from users
  double voteAverage;
  /// List of genre IDs associated with the movie
  List<int> genreIds;
  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.genreIds,
  });

  /// Creates a Movie instance from a JSON map
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      title: map['title'] ?? '',
      posterPath: map['poster_path'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
      overview: map['overview'] ?? '',
      releaseDate: map['release_date'] ?? '',
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      genreIds: List<int>.from(map['genre_ids']),
    );
  }

  /// Creates a Movie instance from a JSON string
  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}
