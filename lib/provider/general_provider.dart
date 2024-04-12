import 'package:green_score/api/general_api.dart';
import 'package:green_score/models/general.dart';
import 'package:flutter/material.dart';

class GeneralProvider extends ChangeNotifier {
  General general = General();

  init(bool handler) async {
    general = await GeneralApi().init(handler);
    notifyListeners();
  }
}
