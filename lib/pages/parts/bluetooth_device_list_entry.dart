import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_light/service/bluetooth_connection_service.dart';

class BluetoothDeviceListEntry extends StatefulWidget {
  final BluetoothDevice device;

  BluetoothDeviceListEntry({@required this.device});

  @override
  State<StatefulWidget> createState() => _BluetoothDeviceListEntryState();
}

class _BluetoothDeviceListEntryState extends State<BluetoothDeviceListEntry> {
  BluetoothConnection connection;
  BluetoothConnectionService _bluetoothService =
      BluetoothConnectionService.instance();

  bool isOn = true;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    isConnected = _bluetoothService.connection != null &&
        _bluetoothService.bluetoothDevice == widget.device &&
        _bluetoothService.connection.isConnected;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // contentPadding: EdgeInsets.symmetric(horizontal: 15),
      leading: Icon(Icons.devices),
      title: Text(widget.device.name ?? "Невідомий пристрій"),
      subtitle: Text(widget.device.address.toString()),
      trailing: ElevatedButton(
        child: isConnected ? Text("Під'єднано") : Text("Під'єдатися"),
        onPressed: isConnected ? null : connectToDevice,
      ),
    );
  }

  void connectToDevice() {
    print('Connecting to the device');
    _bluetoothService.connect(widget.device).then((value) {
      Fluttertoast.showToast(
          msg: "Під'єднано!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        isConnected = true;
      });
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
          msg: "Не вдалося під'єднатися!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}
