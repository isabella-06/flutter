// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supabase_notes/app/modules/home/controllers/home_controller.dart';

import '../controllers/add_note_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  HomeController homeC = Get.find();

  AddNoteView({super.key}); // get controller from another controller
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Agregar Libro'), // Cambio: título acorde a libros.
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
                    bool res = await controller.addBook();
                    if (res == true) {
                      await homeC.getAllBooks();
                      Get.back();
                    }
                    controller.isLoading.value = false;
                  }
                },
                child: Text(
                    controller.isLoading.isFalse ? "Agregar libro" : "Cargando...")))
          ],
        ));
  }
}
