import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_light/enums/app_routes.dart';
import 'package:smart_light/service/arduino/bluetooth_command_service.dart';
import 'package:smart_light/service/util_service.dart';

class PowerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PowerPageState();
}

class _PowerPageState extends State<PowerPage> {
  Future<BluetoothCommandService> _bluetoothCommandService;

  @override
  void initState() {
    super.initState();
    _bluetoothCommandService = UtilService.connectToBluetooth();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FutureBuilder<BluetoothCommandService>(
        future: _bluetoothCommandService,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Center(
            child: IconButton(
              iconSize: 120,
              icon: Icon(
                Icons.power_settings_new_rounded,
                color: Colors.blue,
              ),
              onPressed: () {
                snapshot.data.power();
              },
            ),
          )
              : Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
          );
        },
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
