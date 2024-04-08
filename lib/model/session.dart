import 'package:flutter/foundation.dart';

import 'user.dart';


class Session extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  set user(User? value) {
    _user = value;
    notifyListeners();
  }
}