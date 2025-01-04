import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class JournalEntry extends HiveObject {
  @HiveField(0)
  final String text;

  @HiveField(1)
  final String mood;

  @HiveField(2)
  final DateTime date;

  JournalEntry({
    required this.text,
    required this.mood,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'mood': mood,
      'date': date.toIso8601String().trim(),
    };
  }

  factory JournalEntry.fromMap(Map<String, dynamic> map) {
    return JournalEntry(
      text: map['text'] as String,
      mood: map['mood'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }
}
