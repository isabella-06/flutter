
/// Represents a user review for a movie
class Review {
  String author;
  String comment;
  double rating;
  
  Review({
    required this.author,
    required this.comment,
    required this.rating,
  });

  /// Creates a Review instance from a JSON map
  factory Review.fromJson(Map<String, dynamic> map) {
    return Review(
      author: map['name'] ?? '',
      comment: map['content'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }
}
