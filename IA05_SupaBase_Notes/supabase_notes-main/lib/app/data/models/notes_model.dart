class Book {
  // Cambio: modelo actualizado para la tabla "books" (title, author, genre, read_status).
  int? id;
  int? userId;
  String? title;
  String? author;
  String? genre;
  bool? readStatus;
  String? createdAt;

  Book({
    this.id,
    this.userId,
    this.title,
    this.author,
    this.genre,
    this.readStatus,
    this.createdAt,
  });

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    author = json['author'];
    genre = json['genre'];
    readStatus = json['read_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['author'] = author;
    data['genre'] = genre;
    data['read_status'] = readStatus;
    data['created_at'] = createdAt;
    return data;
  }

  static List<Book> fromJsonList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.map((e) => Book.fromJson(e)).toList();
  }
}
