import 'dart:math';
//this is where my data is coming from
class ServiceClass {
  Future<Map<String, dynamic>> fetchHealthMetrics() async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      "steps": Random().nextInt(10000),
      "heartRate": 60 + Random().nextInt(40),
      "sleep": 4 + Random().nextDouble() * 4,
      "lastUpdated": DateTime.now().toUtc().toIso8601String(),
    };
  }
  Future<Map<String, dynamic>> fetchMessage() async {
    await Future.delayed(Duration(seconds: 2));
    return {"message": "You're doing great! Keep it up!"};
  }
  

}


