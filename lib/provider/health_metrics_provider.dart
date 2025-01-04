import 'package:flutter/material.dart';
import 'package:health_journal/services/repository.dart';


class HealthProvider with ChangeNotifier {
  Map<String, dynamic>? healthData;
  bool isLoading = true;

  Future<void> fetchHealthData() async {
    try {
      isLoading = true;
      notifyListeners();
      healthData = await ServiceClass().fetchHealthMetrics();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
