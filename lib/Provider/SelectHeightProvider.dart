import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HeightProvider with ChangeNotifier {
  int _selectedHeightType = 0; // Default selected option
  int _selectedHeightCm = 170;
  int _selectedFeet = 5;
  int _selectedInches = 6;
  // String _selectedWeightKg = "0"; // Default selected option
  // int _selectedWeightLbs = 0; // Default selected option

  int get selectedHeightType => _selectedHeightType;
  int get selectedHeightCm => _selectedHeightCm;
  int get selectedFeet => _selectedFeet;
  int get selectedInches => _selectedInches;
  // int get selectedWeightLbs => _selectedWeightLbs;

  void selectedHeightCollectType(int value) {
    _selectedHeightType = value;
    notifyListeners(); // Notify listeners to rebuild widgets
  }
  void selectedHeightInCm(int value) {
    _selectedHeightCm = value;
    notifyListeners(); // Notify listeners to rebuild widgets
  }
  void selectedHeightInFt(int value) {
    _selectedFeet = value;
    notifyListeners(); // Notify listeners to rebuild widgets
  }
  void selectedHeightInIn(int value) {
    _selectedInches = value;
    notifyListeners(); // Notify listeners to rebuild widgets
  }
  // void selectedWeightInKG(String value) {
  //   _selectedWeightKg = value;
  //   notifyListeners(); // Notify listeners to rebuild widgets
  // }
  // void selectedWeightInLbs(int value) {
  //   _selectedWeightLbs = value;
  //   notifyListeners(); // Notify listeners to rebuild widgets
  // }

}