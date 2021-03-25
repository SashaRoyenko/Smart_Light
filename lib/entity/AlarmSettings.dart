class AlarmSettings {
  DateTime _time;
  bool _isActive;

  AlarmSettings();

  AlarmSettings.name(this._time, this._isActive);

  bool get isActive => _isActive;

  set isActive(bool value) {
    _isActive = value;
  }

  DateTime get time => _time;

  set time(DateTime value) {
    _time = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlarmSettings &&
          runtimeType == other.runtimeType &&
          _time == other._time &&
          _isActive == other._isActive;

  @override
  int get hashCode => _time.hashCode ^ _isActive.hashCode;

  @override
  String toString() {
    return 'AlarmSettings{_duration: $_time, _isActive: $_isActive}';
  }
}