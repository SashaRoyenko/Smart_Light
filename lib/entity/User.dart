import 'package:smart_light/entity/LightSetting.dart';
import 'package:smart_light/entity/Option.dart';

class User {
  String _email;
  String _firstName;
  String _lastName;
  String _password;
  LightSetting _lightSetting;
  List<Option> options;

  User(this._email, this._firstName, this._lastName, this._password,
      this._lightSetting);

  User.name(this._email, this._firstName, this._lastName, this._password,
      this._lightSetting);

  LightSetting get lightSetting => _lightSetting;

  set lightSetting(LightSetting value) {
    _lightSetting = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
  }

  String get firstName => _firstName;

  set firstName(String value) {
    _firstName = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  @override
  String toString() {
    return 'User{_email: $_email, _firstName: $_firstName, _lastName: $_lastName, _password: $_password}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          _email == other._email &&
          _firstName == other._firstName &&
          _lastName == other._lastName &&
          _password == other._password;

  @override
  int get hashCode =>
      _email.hashCode ^
      _firstName.hashCode ^
      _lastName.hashCode ^
      _password.hashCode;
}
