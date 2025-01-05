import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_journal/utils/colors.dart';
import 'package:health_journal/utils/styles.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../../journalling/view/journaling.dart';
import '../../models/journal_model.dart';
import '../../provider/health_metrics_provider.dart';
import '../../provider/journal_provider.dart';
import '../../provider/message_provider.dart';
import '../component/chart.dart';
import '../component/highlight_card.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> _loadJournalEntries() async {
    final journalEntriesBox = Hive.box<JournalEntry>('journals');
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    _openHive();
  }

  Future<void> _openHive() async {
    await Hive.openBox('journals');
    _loadJournalEntries();
  }

  @override
  Widget build(BuildContext context) {
    final journalProvider = Provider.of<JournalProvider>(context);
    Provider.of<MessageProvider>(context);
    final healthProvider = Provider.of<HealthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mood Trends",
          style: AppTextStyles.headerStyle.copyWith(fontSize: 25.sp),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MoodTrendGraph(entries: journalProvider.entries),
              SizedBox(height: 20),
              // The Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMoodLegend(
                    context,
                    'Happy',
                    5.0,
                  ),
                  _buildMoodLegend(
                    context,
                    'Neutral',
                    4.0,
                  ),
                  _buildMoodLegend(
                    context,
                    'Sad',
                    3.0,
                  ),
                  _buildMoodLegend(
                    context,
                    'Angry',
                    2.0,
                  ),
                  _buildMoodLegend(
                    context,
                    'Frustrated',
                    1.0,
                  ),
                ],
              ),
              HighlightCard(entries: journalProvider.entries),
              SizedBox(height: 5.h,),
              Text('Health Metrics'),
              ListView.builder(
                shrinkWrap: true,
                physics:
                NeverScrollableScrollPhysics(),
                itemCount:
                healthProvider.healthData!.length,
                itemBuilder: (context, index) {
                  final key = healthProvider
                      .healthData!.keys
                      .elementAt(index);
                  final value =
                  healthProvider.healthData![key];

                  // Format the "lastUpdated" field for better display
                  String formattedValue =
                  (key == 'lastUpdated' &&
                      value is String)
                      ? DateTime.parse(value)
                      .toLocal()
                      .toString()
                      : value.toString();

                  return Card(
                    child: ListTile(
                      //tileColor: Colors.red,
                      titleTextStyle: AppTextStyles
                          .headerStyle
                          .copyWith(fontSize: 18.sp),
                      trailing: Icon(Icons.health_and_safety),
                      title: Text(
                        key,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        formattedValue,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700]),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [

          Positioned(
            bottom: 50,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: AppColors.defaultBlue,
              onPressed: () {
                journalProvider.clearAllEntries();
              },
              child: Text(
                'Clear',
                style: AppTextStyles.headerStyle
                    .copyWith(color: Colors.white, fontSize: 14.sp),
              ),
            ),
          ),
          // Bottom-left floating action button
          Positioned(
            bottom: 50,
            left: 40,
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {
                // Add the action for this button
                print("Bottom-left button pressed!");
              },
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JournalingScreen()));
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            ),
          ),

        ],
      ),
    );
  }
}

Widget _buildMoodLegend(
    BuildContext context,
    String mood,
    double value,
    ) {
  return Column(
    children: [
      //Icon(Icons.circle, color: color, size: 16),
      // SizedBox(height: 4),
      Text(
        mood,
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
      Text(
        value.toString(),
        style: TextStyle(fontSize: 10, color: Colors.grey),
      ),
    ],
  );
}
