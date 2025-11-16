import 'package:hive/hive.dart';


part 'note.g.dart';


@HiveType(typeId: 10)
class Note {
@HiveField(0)
final String id;


@HiveField(1)
final String title;


@HiveField(2)
final String content;


@HiveField(3)
final DateTime createdAt;


@HiveField(4)
final DateTime? updatedAt;


Note({
required this.id,
required this.title,
required this.content,
required this.createdAt,
this.updatedAt,
});


factory Note.fromJson(Map<String, dynamic> json) {
return Note(
id: json['id']?.toString() ?? '',
title: json['title'] ?? '',
content: json['content'] ?? '',
createdAt: DateTime.parse(json['created_at'] ?? json['createdAt'] ?? DateTime.now().toIso8601String()),
updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
);
}


Map<String, dynamic> toJson() {
return {
'id': id,
'title': title,
'content': content,
'created_at': createdAt.toIso8601String(),
if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
};
}
}