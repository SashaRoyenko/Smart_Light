import 'dart:ui';

import 'package:flutter/material.dart';

class LightState extends ChangeNotifier {
  bool isPowerOn = false;
  Color currentColor = Colors.white;
  int brightness = 100;
  bool isAuto = false;
  bool isAlarm = false;
  DateTime alarmTime = DateTime.now();
  DateTime currentTime = DateTime.now();
  static LightState _lightState;

  LightState._();

  static LightState getInstance() {
    if (_lightState == null) {
      _lightState = LightState._();
    }
    return _lightState;
  }

  void updateFromString(String lightSettings) {
    List<String> settings = lightSettings.split("\n");

    List<String> powerSettings = settings[0].split(" ");
    this.isPowerOn = int.parse(powerSettings[1]) == 1;

    List<String> lightSetting = settings[1].split(" ");
    this.currentColor = Color.fromRGBO(int.parse(lightSetting[1]),
        int.parse(lightSetting[2]), int.parse(lightSetting[3]), 1.0);

    List<String> brightnessSetting = settings[2].split(" ");
    this.brightness = int.parse(brightnessSetting[1]);

    List<String> autoSetting = settings[3].split(" ");
    this.isAuto = int.parse(autoSetting[1]) == 1;

    List<String> alarmSetting = settings[4].split(" ");
    this.alarmTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(alarmSetting[1]),
        int.parse(alarmSetting[2]),
        0,
        0,
        0);
    this.isAlarm = int.parse(alarmSetting[3]) == 1;

    List<String> currentTimeSetting = settings[5].split(" ");
    this.currentTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(currentTimeSetting[1]),
        int.parse(currentTimeSetting[2]),
        0,
        0,
        0);
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  @override
  String toString() {
    return 'LightState{isPowerOn: $isPowerOn, currentColor: $currentColor, brightness: $brightness, isAuto: $isAuto, isAlarm: $isAlarm, alarmTime: $alarmTime}';
  }
}
