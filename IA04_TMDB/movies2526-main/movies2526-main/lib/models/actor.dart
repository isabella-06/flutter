import 'dart:convert';

/// Represents an actor/person with details fetched from TMDB API
class Actor {
  /// Unique identifier for the actor
  int id;
  /// Full name of the actor
  String name;
  /// URL path to the actor's profile picture
  String profilePath;
  /// Biographical information about the actor
  String biography;
  /// Popularity score of the actor
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