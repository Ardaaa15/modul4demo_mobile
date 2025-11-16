import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notes_controller.dart';
import '../models/note.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NotesController c = Get.put(NotesController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Catatan"),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () => c.syncNotesFromCloud(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/note-edit'),
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (c.notes.isEmpty) {
          return const Center(child: Text("Belum ada catatan"));
        }

        return ListView.builder(
          itemCount: c.notes.length,
          itemBuilder: (context, index) {
            final Note n = c.notes[index];
            return ListTile(
              title: Text(n.title),
              subtitle: Text(n.content),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => c.deleteNote(n.id),
              ),
              onTap: () => Get.toNamed('/note-edit', arguments: n),
            );
          },
        );
      }),
    );
  }
}
