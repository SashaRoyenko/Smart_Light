import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_light/enums/app_routes.dart';
import 'package:smart_light/service/arduino/bluetooth_command_service.dart';
import 'package:smart_light/service/bluetooth_connection_service.dart';

class PowerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PowerPageState();
}

class _PowerPageState extends State<PowerPage> {
  BluetoothConnectionService _bluetoothService =
      BluetoothConnectionService.instance();
  BluetoothCommandService _bluetoothCommandService;

  @override
  void initState() {
    super.initState();
    _bluetoothService = BluetoothConnectionService.instance();
    BluetoothConnection connection = _bluetoothService.connection;
    if (connection == null) {
      Fluttertoast.showToast(
          msg: "Не вдалося під'єднатися!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      _bluetoothCommandService = BluetoothCommandService(connection);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: IconButton(
          iconSize: 120,
          icon: Icon(
            Icons.power_settings_new_rounded,
            color: Colors.blue,
          ),
          onPressed: () {
            _bluetoothCommandService.power();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.access_time),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.TIME);
        },
      ),
    );
  }
}
