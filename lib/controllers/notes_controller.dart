import 'dart:io';
import 'package:get/get.dart';
import '../models/note.dart';
import '../services/hive_service.dart';
import '../services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotesController extends GetxController {
  final hive = HiveService();
  var notes = <Note>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadLocalNotes();
  }

  Future<void> loadLocalNotes() async {
    final fetched = await hive.fetchNotes(); // List<Note>
    notes.assignAll(fetched);
  }

  Future<void> addNote(Note note) async {
    isLoading(true);
    try {
      await hive.addNote(note);
      await SupabaseService.addNote(note);
      await loadLocalNotes(); // reload terbaru
      Get.snackbar('Sukses', 'Catatan ditambahkan');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateNote(Note note) async {
    isLoading(true);
    try {
      await hive.updateNote(note);
      await SupabaseService.updateNote(note);
      await loadLocalNotes();
      Get.snackbar('Sukses', 'Catatan diperbarui');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteNote(String id) async {
    isLoading(true);
    try {
      await hive.deleteNote(id);
      await SupabaseService.deleteNote(id);
      await loadLocalNotes();
      Get.snackbar('Sukses', 'Catatan dihapus');
    } finally {
      isLoading(false);
    }
  }

  Future<String?> uploadImage(File file) async {
    try {
      final fileName =
          'notes/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
      await Supabase.instance.client.storage.from('notes').upload(fileName, file);
      final url = Supabase.instance.client.storage.from('notes').getPublicUrl(fileName);
      return url;
    } catch (e) {
      Get.snackbar('Error', 'Gagal upload gambar: $e');
      return null;
    }
  }
}
