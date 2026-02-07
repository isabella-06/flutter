import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddNoteController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController titleC = TextEditingController();
  TextEditingController authorC = TextEditingController();
  TextEditingController genreC = TextEditingController();
  RxBool readStatus = false.obs; // Cambio: estado de lectura para tabla books.
  SupabaseClient client = Supabase.instance.client;

  Future<bool> addBook() async {
    // Cambio: validación y creación de libros con campos de books.
    if (titleC.text.isNotEmpty && authorC.text.isNotEmpty) {
      isLoading.value = true;
      List<dynamic> res = await client
          .from("users")
          .select("id")
          .match({"uid": client.auth.currentUser!.id});
      Map<String, dynamic> user = (res).first as Map<String, dynamic>;
      int id = user["id"]; //get and match user id before insert to db
      await client.from("books").insert({
        "user_id": id, // Cambio: insert con user_id como FK.
        "title": titleC.text,
        "author": authorC.text,
        "genre": genreC.text,
        "read_status": readStatus.value,
        "created_at": DateTime.now().toIso8601String(),
      });
      return true;
    } else {
      return false;
    }
  }
}
