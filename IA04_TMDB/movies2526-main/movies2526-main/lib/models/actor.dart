import 'dart:convert';

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

  factory Actor.fromMap(Map<String, dynamic> map) {
    return Actor(
      id: map['id'] as int,
      name: map['name'] ?? '',
      profilePath: map['profile_path'] ?? '',
      biography: map['biography'] ?? '', // This field comes from the detail endpoint
      popularity: map['popularity']?.toDouble() ?? 0.0,
    );
  }

  factory Actor.fromJson(String source) => Actor.fromMap(json.decode(source));
}