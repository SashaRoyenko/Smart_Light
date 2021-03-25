class TimerSetting {
  DateTime _time;
  bool _isTurnOn;


  TimerSetting();

  TimerSetting.name(this._time, this._isTurnOn);

  bool get isTurnOn => _isTurnOn;

  set isTurnOn(bool value) {
    _isTurnOn = value;
  }

  DateTime get time => _time;

  set time(DateTime value) {
    _time = value;
  }

  set timeFromDuration(Duration duration) {
    _time = DateTime.fromMillisecondsSinceEpoch(duration.inMilliseconds);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimerSetting &&
          runtimeType == other.runtimeType &&
          _time == other._time &&
          _isTurnOn == other._isTurnOn;

  @override
  int get hashCode => _time.hashCode ^ _isTurnOn.hashCode;

  @override
  String toString() {
    return 'Timer{_duration: $_time, _isTurnOn: $_isTurnOn}';
  }
}