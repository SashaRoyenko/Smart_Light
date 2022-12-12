import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_light/entity/Device.dart';
import 'package:smart_light/service/arduino/CommandService.dart';

import '../shared_preferences_service.dart';
import 'mqtt_service.dart';

class MQTTCommandService implements CommandService {
  static final mqttService = MQTTService.instance;
  var topic = "";

  SharedPreferencesService _sharedPreferencesService;


  MQTTCommandService._() {
    _sharedPreferencesService = SharedPreferencesService.getInstance();
  }

  static final instance = MQTTCommandService._();

  Future<void> _executeCommand(String command) async {
    Device device = Device.fromJson(
        _sharedPreferencesService.getObject("active_device"));
    if (device == null || device.id == null) {
      Fluttertoast.showToast(
          msg: "Не обрано пристрій",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      topic = device.id + "/control";
      mqttService.publishMessage(topic, command);
    }
  }

  @override
  void alarm(DateTime time) {
    // TODO: implement alarm
  }

  @override
  void auto(int isAuto) {
    _executeCommand("auto $isAuto");
  }

  @override
  void brightness(int brightness) {
    String command = "brightness $brightness";
    _executeCommand(command);
  }

  @override
  void light(Color color) {
    String command = "light " +
        color.red.toString() +
        " " +
        color.green.toString() +
        " " +
        color.blue.toString() +
        "\n";
    _executeCommand(command);
  }

  @override
  void power(int power) {
    _executeCommand("power $power");
  }

  @override
  void read() {
    // TODO: implement read
  }

  @override
  void stopAlarm() {
    // TODO: implement stopAlarm
  }

  @override
  void temperature(int temperature) {
    String command = "temperature $temperature";
    _executeCommand(command);
  }

  @override
  void timer(DateTime time, int isOn) {
    String command = "timer " +
        time.hour.toString() +
        " " +
        time.minute.toString() +
        " " +
        time.second.toString() +
        " " +
        isOn.toString();

    _executeCommand(command);
  }

  @override
  void utc(int utc) {
    String command = "utc $utc";
    _executeCommand(command);
  }

  void healthCheck() {
    _executeCommand("health");
  }

  @override
  void user(String userId, int age, int gender) {
    _executeCommand("user $userId $age $gender");
  }
}
