import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomePageProvider with ChangeNotifier {
  int _currentStep = 0; // Default selected option

  int get currentStep => _currentStep;

  void setIndexVal(int value) {
    _currentStep = value;
    notifyListeners(); // Notify listeners to rebuild widgets
  }
}