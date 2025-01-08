class User {
  int _id;
  String _email;
  String _password;
  int _role;

  User(this._id, this._email, this._password, this._role);

  int get id => _id;
  String get email => _email;
  String get password => _password;
  int get role => _role;

  set password(String value)=>_password = value;
  set role(int value) =>_role = value;

}