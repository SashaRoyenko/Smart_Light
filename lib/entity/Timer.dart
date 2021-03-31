class TimerSetting {
  DateTime _time;
  bool _isTurnOn;
  DateTime _validityTime;

  set timeFromDuration(Duration duration) {
    _time = DateTime.fromMillisecondsSinceEpoch(duration.inMilliseconds,
        isUtc: true);
    if (_validityTime == null) {
      _validityTime = DateTime.now().add(Duration(
        hours: _time.hour,
        minutes: _time.minute,
        seconds: _time.second,
      ));
    }
  }

  static TimerSetting fromJson(Map<String, dynamic> json) {
    TimerSetting result = TimerSetting()
      ..isTurnOn = json['isTurnOn']
      .._validityTimeFromJson = DateTime.fromMillisecondsSinceEpoch(
          int.parse(json['validityTime'].toString()))
      .._timeFromJson = DateTime.fromMillisecondsSinceEpoch(
          int.parse(json['time'].toString()));
    return result;
  }

  Map<String, dynamic> toJson() => {
        'time': time.millisecondsSinceEpoch,
        'validityTime': validityTime.millisecondsSinceEpoch,
        'isTurnOn': isTurnOn,
      };

  bool get isTurnOn => _isTurnOn;

  set isTurnOn(bool value) {
    _isTurnOn = value;
  }

  DateTime get validityTime => _validityTime;

  DateTime get time => _time;

  set time(DateTime value) {
    _time = value;

    if (_validityTime == null) {
      _validityTime = DateTime.now().add(Duration(
        hours: _time.hour,
        minutes: _time.minute,
        seconds: _time.second,
      ));
    }
  }

  set _timeFromJson(DateTime value) {
    _time = value;
  }

  set _validityTimeFromJson(DateTime value) {
    _validityTime = value;
  }
}
