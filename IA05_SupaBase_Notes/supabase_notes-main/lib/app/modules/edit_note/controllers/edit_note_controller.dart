import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditNoteController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController titleC = TextEditingController();
  TextEditingController authorC = TextEditingController();
  TextEditingController genreC = TextEditingController();
  RxBool readStatus = false.obs; // Cambio: estado de lectura del libro.
  SupabaseClient client = Supabase.instance.client;

  Future<bool> editBook(int id) async {
    // Cambio: edición de libros con campos author/genre/read_status.
    if (titleC.text.isNotEmpty && authorC.text.isNotEmpty) {
      isLoading.value = true;
      await client
          .from("books")
          .update({
            "title": titleC.text,
            "author": authorC.text,
            "genre": genreC.text,
            "read_status": readStatus.value,
          }).match({
        "id": id,
      });
      return true;
    } else {
      return false;
    }
  }
}
