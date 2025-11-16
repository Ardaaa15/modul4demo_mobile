import 'package:hive_flutter/hive_flutter.dart';
import '../models/note.dart';

class HiveService {
  static HiveService? _instance;
  static HiveService get instance => _instance ??= HiveService();

  static late Box notesBox;

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(NoteAdapter());

    notesBox = await Hive.openBox('notesBox');
  }

  List<Note> fetchNotes() {
    return notesBox.values.cast<Note>().toList();
  }

  Future<void> addNote(Note note) async {
    await notesBox.put(note.id, note);
  }

  Future<void> updateNote(Note note) async {
    await notesBox.put(note.id, note);
  }

  Future<void> deleteNote(String id) async {
    await notesBox.delete(id);
  }

  Future<void> syncFromCloud(List<Note> notes) async {
    await notesBox.clear();
    for (var n in notes) {
      await notesBox.put(n.id, n);
    }
  }
}
