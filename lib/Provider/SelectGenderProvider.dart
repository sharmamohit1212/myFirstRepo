import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SelectGenderProvider with ChangeNotifier {
  int _selectedOption = 0; // Default selected option

  int get selectedOption => _selectedOption;

  void setSelectedOption(int value) {
    _selectedOption = value;
    notifyListeners(); // Notify listeners to rebuild widgets
  }
}