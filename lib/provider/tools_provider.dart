import 'package:flutter/material.dart';

class ToolsProvider extends ChangeNotifier {
  int stepped = 0;
  int accumulatedSteps = 0;
  int threshold = 0;
  String id = '';
  String walkDescription = '0 алхам = 0GS';
  String scooterDescription = '0 төг = 0GS';
  List<double> stepsForLast7Days = List<double>.filled(7, 0.0);

  void setStepped(int value) {
    stepped = value;
    notifyListeners();
  }

  void resetAccumulatedSteps() {
    accumulatedSteps = 0;
    notifyListeners();
  }

  void addDifference(int steps) {
    accumulatedSteps += steps;
    notifyListeners();
  }

  void addSteps(int steps) {
    stepped += steps;
    notifyListeners();
  }

  updateAll({
    required List<double> steps,
    required String newId,
    required String newWalkDescription,
    required String newScooterDescription,
    required int newThreshold,
  }) {
    stepsForLast7Days = steps;
    id = newId;
    walkDescription = newWalkDescription;
    scooterDescription = newScooterDescription;
    threshold = newThreshold;
    notifyListeners();
  }
}
