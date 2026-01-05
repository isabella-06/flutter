import 'dart:convert';

/// Represents a TV series with details fetched from TMDB API
class Serie {
  /// Unique identifier for the series
  int id;
  /// Title/name of the TV series
  String name;
  /// URL path to the series poster image
  String posterPath;
  /// URL path to the series backdrop image
  String backdropPath;
  /// Plot summary/description of the series
  String overview;
  /// Date when the series first aired
  String firstAirDate;
  /// Average vote/rating score from users
  double voteAverage;

  Serie({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.firstAirDate,
    required this.voteAverage,
  });

  /// Creates a Serie instance from a JSON map
  factory Serie.fromMap(Map<String, dynamic> map) {
    return Serie(
      id: map['id'] as int,
      name: map['name'] ?? '',
      posterPath: map['poster_path'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
      overview: map['overview'] ?? '',
      firstAirDate: map['first_air_date'] ?? '',
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
    );
  }

  /// Creates a Serie instance from a JSON string
  factory Serie.fromJson(String source) => Serie.fromMap(json.decode(source));
}