class AlarmSettings {
  DateTime time;
  bool isActive;


  AlarmSettings();

  AlarmSettings.name(this.time, this.isActive);

  static AlarmSettings fromJson(Map<String, dynamic> json) => AlarmSettings()
    ..isActive = json['isActive']
    ..time =
        DateTime.fromMillisecondsSinceEpoch(int.parse(json['time'].toString()), isUtc: false);

  Map<String, dynamic> toJson() => {
        'time': time.millisecondsSinceEpoch,
        'isActive': isActive,
      };
}
