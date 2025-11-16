import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notes_controller.dart';
import '../models/note.dart';

class NoteEditPage extends StatefulWidget {
  const NoteEditPage({super.key});

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  final titleC = TextEditingController();
  final contentC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final NotesController c = Get.find();
    final Note? n = Get.arguments;

    if (n != null) {
      titleC.text = n.title;
      contentC.text = n.content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(n == null ? 'Tambah Catatan' : 'Edit Catatan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleC,
              decoration: const InputDecoration(labelText: "Judul"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contentC,
              maxLines: 5,
              decoration: const InputDecoration(labelText: "Isi Catatan"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (titleC.text.trim().isEmpty) {
                  Get.snackbar('Error', 'Judul wajib diisi');
                  return;
                }

                if (n == null) {
                  final note = Note(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleC.text.trim(),
                    content: contentC.text.trim(),
                    createdAt: DateTime.now(),
                    updatedAt: null,
                  );
                  await c.addNote(note);
                } else {
                  final updated = Note(
                    id: n.id,
                    title: titleC.text.trim(),
                    content: contentC.text.trim(),
                    createdAt: n.createdAt,
                    updatedAt: DateTime.now(),
                  );
                  await c.updateNote(updated);
                }

                Get.back();
              },
              child: Text(n == null ? "Tambah" : "Simpan"),
            )
          ],
        ),
      ),
    );
  }
}
