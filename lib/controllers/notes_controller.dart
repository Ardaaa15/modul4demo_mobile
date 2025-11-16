import 'package:get/get.dart';
import '../models/note.dart';
import '../services/hive_service.dart';
import '../services/supabase_service.dart';

class NotesController extends GetxController {
  final hive = HiveService();
  final supabase = SupabaseService();

  var notes = <Note>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    loadLocalNotes();
    super.onInit();
  }

  Future<void> loadLocalNotes() async {
    notes.value = hive.fetchNotes();
  }

  Future<void> addNote(Note note, {bool pushToCloud = true}) async {
    isLoading(true);
    try {
      await hive.addNote(note);
      if (pushToCloud) {
        await supabase.addNote(note);
      }
      loadLocalNotes();
      Get.snackbar('Sukses', 'Catatan ditambahkan');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateNote(Note note, {bool pushToCloud = true}) async {
    isLoading(true);
    try {
      await hive.updateNote(note);
      if (pushToCloud) {
        await supabase.updateNote(note);
      }
      loadLocalNotes();
      Get.snackbar('Sukses', 'Catatan diperbarui');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteNote(String id, {bool pushToCloud = true}) async {
    isLoading(true);
    try {
      await hive.deleteNote(id);
      if (pushToCloud) {
        await supabase.deleteNote(id);
      }
      loadLocalNotes();
      Get.snackbar('Sukses', 'Catatan dihapus');
    } finally {
      isLoading(false);
    }
  }

  Future<void> syncNotesFromCloud() async {
    isLoading(true);
    try {
      final data = await supabase.fetchNotes();
      await hive.syncFromCloud(data);
      loadLocalNotes();
      Get.snackbar('Sync', 'Sinkronisasi selesai');
    } finally {
      isLoading(false);
    }
  }
}
