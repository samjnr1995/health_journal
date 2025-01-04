import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../models/journal_model.dart';

class MoodTrendGraph extends StatefulWidget {
  final List<JournalEntry> entries;

  MoodTrendGraph({required this.entries});

  @override
  State<MoodTrendGraph> createState() => _MoodTrendGraphState();
}

class _MoodTrendGraphState extends State<MoodTrendGraph> {
  @override
  Widget build(BuildContext context) {
    final moodSpots = _generateMoodSpots(widget.entries);
    final xAxisLabels = _getFormattedDates(widget.entries);

    return SizedBox(
      height: 200, // Adjust height of the graph
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: false, // Disable grid lines
            ),
            titlesData: FlTitlesData(
              rightTitles:AxisTitles(
                sideTitles: SideTitles(showTitles: false), // Hide Y-axis numbers
              ) ,
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false), // Hide Y-axis numbers
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true), // Hide Y-axis numbers
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (value < 0 || value >= xAxisLabels.length) return Container();
                    return Text(
                      xAxisLabels[value.toInt()],
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    );
                  },
                  reservedSize: 22,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: false, // Disable border lines
            ),
            minX: 0,
            maxX: moodSpots.isNotEmpty ? moodSpots.length - 1.toDouble() : 1,
            minY: 1,
            maxY: 5,
            lineBarsData: [
              LineChartBarData(
                spots: moodSpots,
                isCurved: true,
                barWidth: 3,
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                isStrokeCapRound: true,
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [Colors.blue.withOpacity(0.3), Colors.purple.withOpacity(0.1)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    final colors = [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue];
                    return FlDotCirclePainter(
                      radius: 6,
                      color: colors[index % colors.length], // Unique color for each point
                      strokeWidth: 2,
                      strokeColor: Colors.white,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<FlSpot> _generateMoodSpots(List<JournalEntry> entries) {
  final moodMapping = {
    "Happy": 5.0,
    "Neutral": 4.0,
    "Sad": 3.0,
    "Angry": 2.0,
    "Frustrated": 1.0,
  };

  // Limit to first seven entries
  final limitedEntries = entries.take(7).toList();

  // Generate spots for the graph
  return List<FlSpot>.generate(
    limitedEntries.length,
        (index) {
      final moodValue = moodMapping[limitedEntries[index].mood] ?? 0.0;
      return FlSpot(index.toDouble(), moodValue);
    },
  );
}

List<String> _getFormattedDates(List<JournalEntry> entries) {
  final limitedEntries = entries.take(7).toList();
  return limitedEntries.map((e) => DateFormat('MMM dd').format(e.date)).toList();
}
