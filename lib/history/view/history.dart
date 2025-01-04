import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/journal_model.dart';
import '../../provider/journal_provider.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final journalProvider = Provider.of<JournalProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal History'),
      ),
      body: journalProvider.entries.isEmpty
          ? Center(
        child: Text(
          "No journal entries yet.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: journalProvider.entries.length,
        itemBuilder: (context, index) {
          final entry = journalProvider.entries[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            elevation: 3,
            child: ListTile(
              leading: Icon(
                Icons.event_note,
                color: Colors.blue,
                size: 32,
              ),
              title: Text(
                DateFormat('MMM dd, yyyy').format(entry.date),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                entry.text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black87),
              ),
              trailing: _getMoodIcon(entry.mood),
              onTap: () {
                _showEntryDetails(context, entry, index, journalProvider);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _getMoodIcon(String mood) {
    final moodIcons = {
      "Happy": Icons.sentiment_very_satisfied,
      "Neutral": Icons.sentiment_neutral,
      "Sad": Icons.sentiment_dissatisfied,
      "Angry": Icons.sentiment_very_dissatisfied,
      "Frustrated": Icons.mood_bad,
    };

    final moodColors = {
      "Happy": Colors.green,
      "Neutral": Colors.blue,
      "Sad": Colors.orange,
      "Angry": Colors.red,
      "Frustrated": Colors.purple,
    };

    return Icon(
      moodIcons[mood] ?? Icons.sentiment_satisfied,
      color: moodColors[mood] ?? Colors.grey,
      size: 32,
    );
  }

  void _showEntryDetails(BuildContext context, JournalEntry entry, int index,
      JournalProvider provider) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('MMM dd, yyyy').format(entry.date),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                entry.text,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      provider.deleteEntry(index);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.delete,color: Colors.white),
                    label: Text("Delete",style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Add logic for editing if required
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.edit),
                    label: Text("Edit"),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
