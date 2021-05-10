import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:smart_light/service/arduino/CommandService.dart';

class BluetoothCommandService implements CommandService {
  final BluetoothConnection _connection;

  BluetoothCommandService(this._connection);

  @override
  void alarm(DateTime time) {
    String command =
        "alarm_on " + time.hour.toString() + " " + time.minute.toString();

    _connection.output.add(utf8.encode(command + "\r\n"));
    _connection.output.allSent;
  }

  @override
  void stopAlarm() {
    _connection.output.add(utf8.encode("alarm_off " + "\r\n"));
    _connection.output.allSent;
  }

  @override
  void color(Color color) {
    String command = "light " +
        color.red.toString() +
        " " +
        color.green.toString() +
        " " +
        color.blue.toString() +
        "\n";
    _connection.output.add(utf8.encode(command + "\r\n"));
    _connection.output.allSent;
  }

  @override
  void power() {
    _connection.output.add(utf8.encode("power " + "\r\n"));
    _connection.output.allSent;
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

    _connection.output.add(utf8.encode(command + "\r\n"));
    _connection.output.allSent;
  }
}
