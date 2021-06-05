import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_light/service/arduino/CommandService.dart';
import 'package:smart_light/service/util_service.dart';

class BluetoothCommandService implements CommandService {
  BluetoothConnection _connection;

  BluetoothCommandService(this._connection);

  @override
  void alarm(DateTime time) {
    String command =
        "alarm_on " + time.hour.toString() + " " + time.minute.toString();

    _executeCommand(command);
  }

  @override
  void stopAlarm() {
    _executeCommand("alarm_off ");
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
    _executeCommand(command);
  }

  @override
  void power() {
    _executeCommand("power ");
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

  Future<void> _executeCommand(String command) async {
    if (_connection != null) {
      if (!_connection.isConnected) {
        _connection = (await UtilService.connectToBluetooth())._connection;
      }
      _connection.output.add(utf8.encode(command + "\r\n"));
      _connection.output.allSent;
    } else {
      Fluttertoast.showToast(
          msg: "Не вдалося під'єднатися!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void brightness(int brightness) {
    String command = "brightness $brightness";
    _executeCommand(command);
  }

  @override
  void auto() {
    _executeCommand("auto ");
  }

  @override
  void time(DateTime dateTime) {
    String command = "time " +
        dateTime.hour.toString() +
        " " +
        dateTime.minute.toString() +
        " " +
        dateTime.second.toString();

    _executeCommand(command);
  }

  @override
  void read() {
    _executeCommand("read ");
  }
}
