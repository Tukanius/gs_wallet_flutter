import 'package:flutter/material.dart';
import 'package:green_score/models/accumlation.dart';

class ToolsProvider extends ChangeNotifier {
  Accumlation walk = Accumlation();
  int stepped = 0;
  int accumulatedSteps = 0;
  int threshold = 0;
  String id = '';
  String walkDescription = '0 алхам = 0GS';
  String scooterDescription = '0 төг = 0GS';

  List<double> stepsForLast7Days = List<double>.filled(7, 0.0);

  void updateSteps(List<double> steps) {
    stepsForLast7Days = steps;
    notifyListeners();
  }

  void updateId(String value) {
    id = value;
    notifyListeners();
  }

  void updatewalkDescription(String value) {
    walkDescription = value;
    notifyListeners();
  }

  void updatescooterDescription(String value) {
    scooterDescription = value;
    notifyListeners();
  }

  void thresholdUpdate(int value) {
    threshold = value;
    notifyListeners();
  }

  // getStep() async {
  //   walk.type = "WALK";
  //   walk.code = "WALK_01";
  //   walk = await ScoreApi().getStep(walk);
  //   if (walk.balanceAmount == 0 || walk.balanceAmount == null) {
  //     stepped = 0;
  //   } else {
  //     stepped = walk.balanceAmount!;
  //   }
  //   notifyListeners();
  // }
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
}
