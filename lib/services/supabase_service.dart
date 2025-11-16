import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/note.dart';

class SupabaseService {
  static Future<void> init() async {
    await Supabase.initialize(
      url: 'https://mpymgxxtukxqvdybodyk.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1weW1neHh0dWt4cXZkeWJvZHlrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjMyMjI4MTksImV4cCI6MjA3ODc5ODgxOX0.lwbY9YvGOnJRddUGqeMbe2N9GahuXS4nU53BdzPkddU',
    );
  }

  final supabase = Supabase.instance.client;

  Future<List<Note>> fetchNotes() async {
    final res = await supabase.from('notes').select().order('created_at');

    return (res as List).map((e) => Note.fromJson(e)).toList();
  }

  Future<void> addNote(Note note) async {
    await supabase.from('notes').insert(note.toJson());
  }

  Future<void> updateNote(Note note) async {
    await supabase
        .from('notes')
        .update(note.toJson())
        .eq('id', note.id);
  }

  Future<void> deleteNote(String id) async {
    await supabase.from('notes').delete().eq('id', id);
  }
}

