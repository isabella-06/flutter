import 'dart:convert';

/// Represents a TV series with details fetched from TMDB API
class Serie {
  int id;
  String name;
  String posterPath;
  String backdropPath;
  String overview;
  String firstAirDate;
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