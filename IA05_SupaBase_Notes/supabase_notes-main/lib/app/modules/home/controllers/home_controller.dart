import 'package:get/get.dart';
import 'package:supabase_notes/app/data/models/notes_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  // Cambio: lista y métodos ahora trabajan con libros.
  RxList allBooks = List<Book>.empty().obs;
  SupabaseClient client = Supabase.instance.client;

  Future<void> getAllBooks() async {
    List<dynamic> res = await client
        .from("users")
        .select("id")
        .match({"uid": client.auth.currentUser!.id});
    Map<String, dynamic> user = (res).first as Map<String, dynamic>;
    int id = user["id"]; // Cambio: obtener user_id antes de cargar libros.
    var books = await client.from("books").select().match(
      {"user_id": id}, // Cambio: traer libros filtrados por user_id.
    );
    List<Book> booksData = Book.fromJsonList((books as List));
    allBooks(booksData);
    allBooks.refresh();
  }

  Future<void> deleteBook(int id) async {
    await client.from("books").delete().match({
      "id": id,
    });
    getAllBooks();
  }
}
