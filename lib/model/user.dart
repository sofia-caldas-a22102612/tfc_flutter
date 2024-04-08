


class User  {
  String _userid;
  String _password;

  User({required String userid, required String password}) :
    _userid = userid, _password = password;

  String get password => _password;
  String get userid => _userid;
}