import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/note.dart';

class SupabaseService {
  static Future<void> init() async {
    await Supabase.initialize(
      url: "https://bxqvzyulnakqnhbeomag.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ4cXZ6eXVsbmFrcW5oYmVvbWFnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjMzMDM2NzQsImV4cCI6MjA3ODg3OTY3NH0.dwNxCR3D6-SnUBInEBfjfCWMBEPx6Gw9heJvKq3p3Z4",
    );
  }

  static SupabaseClient get client => Supabase.instance.client;

  // 🔹 User ID (Auth)
  static String? get userId => client.auth.currentUser?.id;

  // =====================================================
  //                     CRUD NOTES
  // =====================================================

  /// CREATE NOTE
  static Future<void> addNote(Note note) async {
    final uid = userId;
    if (uid == null) throw "User belum login";

    await client.from('notes').insert({
      'id': note.id, // string, no problem (Supabase auto-cast)
      'user_id': uid,
      'title': note.title,
      'content': note.content,
      'created_at': note.createdAt.toIso8601String(),
    });
  }

  /// READ NOTES
  static Future<List<Note>> fetchNotes() async {
    final uid = userId;
    if (uid == null) throw "User belum login";

    final data = await client
        .from('notes')
        .select()
        .eq('user_id', uid)
        .order('created_at', ascending: false);

    return (data as List).map((e) {
      return Note(
        id: e['id'],
        title: e['title'],
        content: e['content'] ?? '',
        createdAt: DateTime.parse(e['created_at']),
        updatedAt: null,
      );
    }).toList();
  }

  /// UPDATE NOTE
  static Future<void> updateNote(Note note) async {
    await client
        .from('notes')
        .update({'title': note.title, 'content': note.content})
        .eq('id', note.id);
  }

  /// DELETE NOTE
  static Future<void> deleteNote(String id) async {
    await client.from('notes').delete().eq('id', id);
  }
}
