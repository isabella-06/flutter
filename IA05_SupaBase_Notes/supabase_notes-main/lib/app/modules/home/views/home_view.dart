import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_notes/app/data/models/notes_model.dart';
import 'package:supabase_notes/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mi Biblioteca'), // Cambio: título acorde a libros.
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                Get.toNamed(Routes.PROFILE);
              },
              icon: const Icon(Icons.person),
            )
          ],
        ),
        body: FutureBuilder(
            future: controller.getAllBooks(), // Cambio: carga de libros.
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Obx(() => controller.allBooks.isEmpty
                  ? const Center(
                      child: Text("SIN LIBROS"),
                    )
                  : ListView.builder(
                      itemCount: controller.allBooks.length,
                      itemBuilder: (context, index) {
                        Book book = controller.allBooks[index];
                        return ListTile(
                          onTap: () => Get.toNamed(
                            Routes.EDIT_NOTE,
                            arguments: book,
                          ),
                          leading: CircleAvatar(
                            child: Text(
                              (book.title?.isNotEmpty ?? false)
                                  ? book.title!.substring(0, 1).toUpperCase()
                                  : "?",
                            ),
                          ),
                          title: Text("${book.title}"),
                          // Cambio: mostrar autor, género y estado de lectura.
                          subtitle: Text(
                            "Autor: ${book.author ?? '-'} | Género: ${book.genre ?? '-'} | Leído: ${(book.readStatus ?? false) ? 'Sí' : 'No'}",
                          ),
                          trailing: IconButton(
                            onPressed: () async =>
                                await controller.deleteBook(book.id!),
                            icon: const Icon(Icons.delete),
                          ),
                        );
                      },
                    ));
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.ADD_NOTE),
          child: const Icon(Icons.add),
        ));
  }
}
