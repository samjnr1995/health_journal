import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/journal_model.dart';

class JournalProvider extends ChangeNotifier {
  final Box _journalBox = Hive.box('journal');
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  List<JournalEntry> get entries {
    return _journalBox.values
        .map((entry) => JournalEntry.fromMap(Map<String, dynamic>.from(entry)))
        .toList();
  }

  Future<void> addEntry(JournalEntry entry) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _journalBox.add(entry.toMap());
    } catch (e) {
      _error = "Failed to save journal entry.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteEntry(int index) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _journalBox.deleteAt(index);
    } catch (e) {
      _error = "Failed to delete journal entry.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> updateEntry(int index, JournalEntry updatedEntry) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _journalBox.putAt(index, updatedEntry.toMap());
    } catch (e) {
      _error = "Failed to update journal entry.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  JournalEntry? getEntry(int index) {
    if (index < 0 || index >= _journalBox.length) {
      _error = "Invalid index.";
      return null;
    }
    final entry = _journalBox.getAt(index);
    return entry != null
        ? JournalEntry.fromMap(Map<String, dynamic>.from(entry))
        : null;
  }

  Future<void> clearAllEntries() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _journalBox.clear();
    } catch (e) {
      _error = "Failed to clear journal entries.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
