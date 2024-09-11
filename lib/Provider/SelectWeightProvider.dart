import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class WeightProvider with ChangeNotifier {
  int _selectedWeightType = 0; // Default selected option
  String _selectedWeightKg = "0"; // Default selected option
  int _selectedWeightLbs = 0; // Default selected option

  int get selectedWeightType => _selectedWeightType;
  String get selectedWeightKg => _selectedWeightKg;
  int get selectedWeightLbs => _selectedWeightLbs;

  void selectedWeightCollectType(int value) {
    _selectedWeightType = value;
    notifyListeners(); // Notify listeners to rebuild widgets
  }
  void selectedWeightInKG(String value) {
    _selectedWeightKg = value;
    notifyListeners(); // Notify listeners to rebuild widgets
  }
  void selectedWeightInLbs(int value) {
    _selectedWeightLbs = value;
    notifyListeners(); // Notify listeners to rebuild widgets
  }

}