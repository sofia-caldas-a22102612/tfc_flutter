import 'package:flutter/foundation.dart';
import 'package:tfc_flutter/model/patient.dart';
import 'user.dart';


class Session extends ChangeNotifier {
  User? _user;
  Patient? _patient;

  User? get user => _user;
  Patient? get patient => _patient;


  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  set patient(Patient? value) {
    _patient = value;
    notifyListeners();
  }
}