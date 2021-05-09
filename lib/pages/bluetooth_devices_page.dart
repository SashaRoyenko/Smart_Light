import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:smart_light/pages/parts/bluetooth_device_list_entry.dart';

class BluetoothDevicesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BluetoothDevicesPageState();
}

class _BluetoothDevicesPageState extends State<BluetoothDevicesPage> {
  Future<List<BluetoothDevice>> devices;

  @override
  void initState() {
    super.initState();
    initDevices();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initDevices() async {
    devices = FlutterBluetoothSerial.instance.getBondedDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Оберіть пристрій"),
        ),
        body: FutureBuilder<List<BluetoothDevice>>(
          future: devices,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    ListView(
                      shrinkWrap: true,
                      children: getDevices(snapshot.data),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Text(
                      "Якщо ви не бачите необхідного пристрою, "
                      "то спочатку приєднайтеся за допомогою налаштувань",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
              );
            }
          },
        ));
  }

  List<Widget> getDevices(List<BluetoothDevice> data) {
    return data
        .map(
          (_device) => BluetoothDeviceListEntry(
            device: _device,
          ),
        )
        .toList();
  }
}
