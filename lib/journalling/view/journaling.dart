import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_journal/shared/reusables/text_field.dart';
import 'package:health_journal/utils/colors.dart';
import 'package:provider/provider.dart';
import '../../models/journal_model.dart';
import '../../provider/health_metrics_provider.dart';
import '../../provider/journal_provider.dart';
import '../../provider/message_provider.dart';
import '../../shared/reusables/custom_button.dart';
import '../../splash/view/splash_three.dart';
import '../../utils/styles.dart';
import '../component/moodDateButton.dart';

class JournalingScreen extends StatefulWidget {
  @override
  _JournalingScreenState createState() => _JournalingScreenState();
}

class _JournalingScreenState extends State<JournalingScreen> {
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedMood;
  IconData? selectedMoodIcon;

  final List<Map<String, dynamic>> moods = [
    {'icon': Icons.sentiment_very_satisfied, 'text': 'Happy'},
    {'icon': Icons.sentiment_neutral, 'text': 'Neutral'},
    {'icon': Icons.sentiment_dissatisfied, 'text': 'Sad'},
    {'icon': Icons.mood_bad, 'text': 'Angry'},
    {'icon': Icons.sentiment_very_dissatisfied, 'text': 'Frustrated'},
  ];

  String get formattedDateTime {
    if (selectedDate == null || selectedTime == null) {
      return "Select time";
    } else {
      return "${selectedDate!.year}|${selectedDate!.month}|${selectedDate!.day}, ${selectedTime!.format(context)}";
    }
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
      await _pickTime();
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  void _showMoodDropdown() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          children: moods
              .map(
                (mood) => ListTile(
              leading: Icon(mood['icon'], color: Colors.orange.shade300),
              title: Text(
                mood['text'],
                style: AppTextStyles.headerStyle
                    .copyWith(fontSize: 16.sp, color: Colors.black45),
              ),
              onTap: () {
                setState(() {
                  selectedMood = mood['text'];
                  selectedMoodIcon = mood['icon'];
                });
                Navigator.pop(context);
              },
            ),
          )
              .toList(),
        );
      },
    );
  }

  Future<void> _saveJournalEntry(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final journalProvider =
    Provider.of<JournalProvider>(context, listen: false);
    final entryDate = selectedDate;

    if (selectedMood == null || selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select mood and schedule')),
      );
      return;
    }
    try {
      _isLoading = true;
      final entry = JournalEntry(
        text: _textController.text.trim(),
        mood: selectedMood!,
        date: entryDate!,
      );
      await journalProvider.addEntry(entry);
      print('the entries are ${entry.date} ${entry.mood}, ${entry.text}');
      //_textController.clear();
      setState(() {
        selectedMood = null;
        selectedMoodIcon = null;
        selectedDate = null;
        selectedTime = null;
      });
      _isLoading = false;
      _showSuccess(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save entry. Try again!')),
      );
    }
  }

  void _showSuccess(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Your journal entry has been saved!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreenThree()),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final messageProvider = Provider.of<MessageProvider>(context);
    final healthProvider = Provider.of<HealthProvider>(context);
    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text(
                        "Start ",
                        style: AppTextStyles.headerStyle.copyWith(
                          fontSize: 30.sp,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Journaling",
                        style: AppTextStyles.headerStyle.copyWith(
                          fontSize: 30.sp,
                          color: AppColors.defaultBlue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustomField(
                    data: _textController,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required field.';
                      } else if (value.length < 3) {
                        return 'Journal entry is too short';
                      }
                      return null;
                    },
                    maxlines: 8,
                    maxlength: 1000,
                    hint: 'Write your thoughts...',
                    type: TextInputType.text,
                  ),

                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MoodDateOptionButton(
                        title: 'Mood',
                        subtitle: selectedMood ?? 'Choose a mood',
                        isSelected: selectedMood != null,
                        iconData: selectedMoodIcon ?? Icons.mood,
                        onMoodTap: _showMoodDropdown,
                      ),
                      MoodDateOptionButton(
                        title: 'Schedule',
                        subtitle: formattedDateTime,
                        isSelected:
                        selectedDate != null && selectedTime != null,
                        iconData: Icons.calendar_month,
                        onMoodTap: _pickDate,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    'Health Metrics',
                    style: AppTextStyles.headerStyle.copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: 20.h,),
                  Transform.translate(
                    offset: Offset(0, -40),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        healthProvider.isLoading
                            ? CircularProgressIndicator()
                            : healthProvider.healthData == null
                            ? Text('Failed to load health data')
                            : ListView.builder(
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
                        SizedBox(height: 10.h,),
                        Text(messageProvider.message ?? 'no message'),
                        SizedBox(height: 20.h),
                        Center(
                          child: CustomButton(
                            loading: _isLoading,
                            color: AppColors.defaultBlue,
                            textColor: Colors.white,
                            text: 'Save Entry',
                            onTap: () => _saveJournalEntry(context),
                          ),
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
