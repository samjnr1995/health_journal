import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_journal/utils/colors.dart';
import 'package:health_journal/utils/styles.dart';
import 'package:intl/intl.dart';
import '../../models/journal_model.dart';

class HighlightCard extends StatelessWidget {
  final List<JournalEntry> entries;

  HighlightCard({required this.entries});

  @override
  Widget build(BuildContext context) {
    final mostPositiveEntry = _getMostPositiveEntry(entries);

    if (mostPositiveEntry == null) {
      return Card(
        elevation: 4,
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "No entries available.",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }

    return Card(
      elevation: 1,
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Most Positive Mood Entry",
                style: AppTextStyles.headerStyle
                    .copyWith(color: AppColors.defaultBlue, fontSize: 20.sp)),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.mood, color: Colors.orange, size: 24),
                SizedBox(width: 8.w),
                Text(
                  mostPositiveEntry.mood,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              "Date: ${DateFormat('MMM dd, yyyy').format(mostPositiveEntry.date)}",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            SizedBox(height: 12),
            Text(
              'journal: ${mostPositiveEntry.text}',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

//this function first map mood to double values, iterate over entries using a for loop to check for the highest mood value
  JournalEntry? _getMostPositiveEntry(List<JournalEntry> entries) {
    if (entries.isEmpty) return null;
    final moodMapping = {
      "Happy": 5.0,
      "Neutral": 4.0,
      "Sad": 3.0,
      "Angry": 2.0,
      "Frustrated": 1.0,
    };
    JournalEntry? mostPositiveEntry;
    double highestMoodValue = 0;
    for (var entry in entries) {
      final moodValue = moodMapping[entry.mood] ?? 0.0;
      if (moodValue > highestMoodValue) {
        highestMoodValue = moodValue;
        mostPositiveEntry = entry;
      }
    }

    return mostPositiveEntry;
  }
}
