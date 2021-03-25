import 'dart:ui';

class LightSetting {
  Color _color;
  int _lightTemperature;
  int _brightness;

  LightSetting(this._color, this._lightTemperature, this._brightness);

  LightSetting.name(this._color, this._lightTemperature, this._brightness);

  int get brightness => _brightness;

  set brightness(int value) {
    _brightness = value;
  }

  int get lightTemperature => _lightTemperature;

  set lightTemperature(int value) {
    _lightTemperature = value;
  }

  Color get color => _color;

  set color(Color value) {
    _color = value;
  }

  @override
  String toString() {
    return 'LightSettings{_color: $_color, _lightTemperature: $_lightTemperature, _brightness: $_brightness}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LightSetting &&
          runtimeType == other.runtimeType &&
          _color == other._color &&
          _lightTemperature == other._lightTemperature &&
          _brightness == other._brightness;

  @override
  int get hashCode =>
      _color.hashCode ^ _lightTemperature.hashCode ^ _brightness.hashCode;
}