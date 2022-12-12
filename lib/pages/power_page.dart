import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_light/entity/LightState.dart';

import '../enums/app_routes.dart';

class PowerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PowerPageState();
}

class _PowerPageState extends State<PowerPage> {
  // Future<BluetoothCommandService> _bluetoothCommandService;

  @override
  void initState() {
    super.initState();
    // _bluetoothCommandService = UtilService.connectToBluetooth();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Consumer<LightState>(
          builder: (context, lightState, child) {
            return IconButton(
              iconSize: 120,
              icon: Icon(
                Icons.power_settings_new_rounded,
                color: lightState.isPowerOn ? Colors.grey : Colors.blue,
              ),
              onPressed: () {
                // snapshot.data.power();
              },
            );
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
