import 'LightSetting.dart';

class Option {
  String _name;
  LightSetting _lightSetting;

  Option(this._name, this._lightSetting);


  String get name => _name;

  set name(String value) {
    _name = value;
  }

  @override
  String toString() {
    return 'Option{_name: $_name, _lightSetting: $_lightSetting}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Option &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _lightSetting == other._lightSetting;

  @override
  int get hashCode => _name.hashCode ^ _lightSetting.hashCode;

  LightSetting get lightSetting => _lightSetting;

  set lightSetting(LightSetting value) {
    _lightSetting = value;
  }
}