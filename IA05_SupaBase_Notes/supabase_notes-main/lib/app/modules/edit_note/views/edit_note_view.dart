// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_notes/app/data/models/notes_model.dart';
import 'package:supabase_notes/app/modules/home/controllers/home_controller.dart';

import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  Book book = Get.arguments; // Cambio: ahora se edita un libro.
  HomeController homeC = Get.find();

  EditNoteView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.titleC.text = book.title ?? ""; // Cambio: cargar título del libro.
    controller.authorC.text = book.author ?? "";
    controller.genreC.text = book.genre ?? "";
    controller.readStatus.value = book.readStatus ?? false;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Editar Libro'), // Cambio: título acorde a libros.
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: controller.titleC,
              decoration: const InputDecoration(
                labelText: "Título",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: controller.authorC,
              decoration: const InputDecoration(
                labelText: "Autor",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: controller.genreC,
              decoration: const InputDecoration(
                labelText: "Género",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => SwitchListTile(
                title: const Text("Leído"),
                value: controller.readStatus.value,
                onChanged: (value) => controller.readStatus.value = value,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    bool res = await controller.editBook(book.id!);
                    if (res == true) {
                      await homeC.getAllBooks();
                      Get.back();
                    }
                    controller.isLoading.value = false;
                  }
                },
                child: Text(
                    controller.isLoading.isFalse ? "Guardar cambios" : "Cargando...")))
          ],
        ));
  }
}
