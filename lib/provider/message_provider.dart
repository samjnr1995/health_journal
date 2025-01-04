import 'package:flutter/material.dart';
import '../services/repository.dart';

class MessageProvider extends ChangeNotifier {
  final ServiceClass _service = ServiceClass();

  String? _message;
  String? _error;
  bool _isLoading = false;

  String? get message => _message;
  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> fetchMessage() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _service.fetchMessage();
      _message = response['message'];
    } catch (e) {
      _error = 'Failed to fetch message.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
