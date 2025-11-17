import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notes_controller.dart';
import '../models/note.dart';
import 'note_edit_page.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NotesController c = Get.put(NotesController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Catatan"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const NoteEditPage()),
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
              leading: n.imageUrl != null
                  ? Image.network(n.imageUrl!, width: 50, height: 50, fit: BoxFit.cover)
                  : null,
              title: Text(n.title),
              subtitle: Text(n.content),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => c.deleteNote(n.id),
              ),
              onTap: () => Get.to(() => const NoteEditPage(), arguments: n),
            );
          },
        );
      }),
    );
  }
}
