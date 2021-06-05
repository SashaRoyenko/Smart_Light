import 'dart:ui';

import 'package:smart_light/service/arduino/CommandService.dart';

class MQTTCommandService implements CommandService{
  @override
  void alarm(DateTime time) {
    // TODO: implement alarm
  }

  @override
  void auto() {
    // TODO: implement auto
  }

  @override
  void brightness(int brightness) {
    // TODO: implement brightness
  }

  @override
  void color(Color color) {
    // TODO: implement color
  }

  @override
  void power() {
    // TODO: implement power
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
  void time(DateTime dateTime) {
    // TODO: implement time
  }

  @override
  void timer(DateTime time, int isOn) {
    // TODO: implement timer
  }

  Future<void> _executeCommand(String command) async {
    // if (_connection != null) {
    //   if (!_connection.isConnected) {
    //     _connection = (await UtilService.connectToBluetooth())._connection;
    //   }
    //   _connection.output.add(utf8.encode(command + "\r\n"));
    //   _connection.output.allSent;
    // } else {
    //   Fluttertoast.showToast(
    //       msg: "Не вдалося під'єднатися!",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 2,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // }
  }

}