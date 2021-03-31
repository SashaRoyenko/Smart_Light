class AlarmSettings {
  DateTime time;
  bool isActive;

  static AlarmSettings fromJson(Map<String, dynamic> json) => AlarmSettings()
    ..isActive = json['isActive']
    ..time =
        DateTime.fromMillisecondsSinceEpoch(int.parse(json['time'].toString()));

  Map<String, dynamic> toJson() => {
        'time': time.millisecondsSinceEpoch,
        'isActive': isActive,
      };
}
