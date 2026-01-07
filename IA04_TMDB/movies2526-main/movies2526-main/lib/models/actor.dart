import 'dart:convert';

/// Represents an actor/person with details fetched from TMDB API
class Actor {
  int id;
  String name;
  String profilePath;
  String biography;
  double popularity;
  
  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.biography,
    required this.popularity,
  });

  /// Creates an Actor instance from a JSON map
  factory Actor.fromMap(Map<String, dynamic> map) {
    return Actor(
      id: map['id'] as int,
      name: map['name'] ?? '',
      profilePath: map['profile_path'] ?? '',
      biography: map['biography'] ?? '',
      popularity: map['popularity']?.toDouble() ?? 0.0,
    );
  }

  /// Creates an Actor instance from a JSON string
  factory Actor.fromJson(String source) => Actor.fromMap(json.decode(source));
}