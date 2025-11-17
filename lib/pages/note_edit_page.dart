import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notes_controller.dart';
import '../models/note.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class NoteEditPage extends StatefulWidget {
  const NoteEditPage({super.key});

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  final titleC = TextEditingController();
  final contentC = TextEditingController();
  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    final NotesController c = Get.find();
    final Note? n = Get.arguments;

    if (n != null && titleC.text.isEmpty) {
      titleC.text = n.title;
      contentC.text = n.content;
    }

    Future<void> pickImage() async {
      if (Platform.isAndroid) {
        var status = await Permission.photos.request();
        if (!status.isGranted) {
          Get.snackbar('Error', 'Izin akses galeri ditolak');
          return;
        }
      }
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (image != null) {
        setState(() => pickedImage = File(image.path));
      }
    }

    Future<void> saveNote() async {
      if (titleC.text.trim().isEmpty) {
        Get.snackbar('Error', 'Judul wajib diisi');
        return;
      }

      c.isLoading(true);
      try {
        String? imageUrl;
        if (pickedImage != null) {
          imageUrl = await c.uploadImage(pickedImage!);
          if (imageUrl == null) {
            Get.snackbar('Error', 'Gagal upload gambar');
            return;
          }
        }

        if (n == null) {
          final note = Note(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: titleC.text.trim(),
            content: contentC.text.trim(),
            createdAt: DateTime.now(),
            updatedAt: null,
            imageUrl: imageUrl,
          );
          await c.addNote(note);
        } else {
          final updated = Note(
            id: n.id,
            title: titleC.text.trim(),
            content: contentC.text.trim(),
            createdAt: n.createdAt,
            updatedAt: DateTime.now(),
            imageUrl: imageUrl ?? n.imageUrl,
          );
          await c.updateNote(updated);
        }

        Get.back(); // Kembali ke NotesPage langsung
      } finally {
        c.isLoading(false);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(n == null ? 'Tambah Catatan' : 'Edit Catatan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: titleC, decoration: const InputDecoration(labelText: "Judul")),
            const SizedBox(height: 16),
            TextField(
              controller: contentC,
              maxLines: 5,
              decoration: const InputDecoration(labelText: "Isi Catatan"),
            ),
            const SizedBox(height: 16),
            if (pickedImage != null)
              Image.file(pickedImage!, width: 150, height: 150, fit: BoxFit.cover),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: pickImage, child: const Text("Upload Gambar")),
            const SizedBox(height: 20),
            Obx(
              () => c.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: saveNote,
                      child: Text(n == null ? "Tambah" : "Simpan"),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
