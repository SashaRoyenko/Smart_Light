import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_light/service/bluetooth_connection_service.dart';

class BluetoothDeviceListEntry extends StatelessWidget {
  final BluetoothDevice device;
  BluetoothConnection connection;
  BluetoothConnectionService _bluetoothService = BluetoothConnectionService.instance();

  BluetoothDeviceListEntry({@required this.device});

  bool isOn = true;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: sendData,
      // contentPadding: EdgeInsets.symmetric(horizontal: 15),
      leading: Icon(Icons.devices),
      title: Text(device.name ?? "Unknown device"),
      subtitle: Text(device.address.toString()),
      trailing: ElevatedButton(
        child: Text('Connect'),
        onPressed: connectToDevice,
      ),
    );
  }

  void connectToDevice() {
    // BluetoothConnection.toAddress(device.address).then((_connection) async {
    //   print('Connected to the device');
    //   connection = _connection;
    //   Fluttertoast.showToast(
    //       msg: "Під'єднано!",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 2,
    //       backgroundColor: Colors.green,
    //       textColor: Colors.white,
    //       fontSize: 16.0
    //   );
    // }).catchError((error) {
    //   print('Cannot connect, exception occured');
    //   print(error);
    //   Fluttertoast.showToast(
    //       msg: "Не вдалося під'єднатися!",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 2,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0
    //   );
    // });

    try {
      print('Connecting to the device');
      _bluetoothService.connect(device);
      Fluttertoast.showToast(
          msg: "Під'єднано!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } on Exception catch (_) {
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

  Future<void> sendData() async {
    if (isOn) {
      connection.output.add(utf8.encode("power 1" + "\r\n"));
      isOn = false;
    } else {
      connection.output.add(utf8.encode("power 0" + "\r\n"));
      isOn = true;
    }
    await connection.output.allSent;
  }
}
