import 'package:flutter/material.dart';
import '../models/note.dart';


class NotesProvider with ChangeNotifier {
final List<Note> _notes = [];


List<Note> get notes => _notes;


void setNotes(List<Note> items) {
_notes.clear();
_notes.addAll(items);
notifyListeners();
}


void addNote(Note note) {
_notes.add(note);
notifyListeners();
}


void updateNote(Note note) {
final i = _notes.indexWhere((n) => n.id == note.id);
if (i >= 0) {
_notes[i] = note;
notifyListeners();
}
}


void deleteNote(String id) {
_notes.removeWhere((n) => n.id == id);
notifyListeners();
}
}