import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:smart_light/entity/LightState.dart';
import 'package:smart_light/service/shared_preferences_service.dart';

class BluetoothConnectionService {
  BluetoothDevice _bluetoothDevice;
  BluetoothConnection _connection;
  static BluetoothConnectionService _bluetoothConnectionService;
  SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService.getInstance();

  BluetoothConnectionService._();

  Future<BluetoothConnection> connect(BluetoothDevice device) async {
    if (_connection == null ||
        _connection != null && _bluetoothDevice.address != device.address ||
        !_connection.isConnected) {
      print('Connecting to the device');
      if (_connection != null) {
        _connection.close();
      }
      _bluetoothDevice = device;
      _connection = await BluetoothConnection.toAddress(device.address).onError(
          (error, stackTrace) async =>
              await BluetoothConnection.toAddress(device.address));
      _sharedPreferencesService.putObject("bluetooth_device", device.toMap());

      connection.input.listen((Uint8List data) {
        String lightSettings = ascii.decode(data);
        print('Data incoming: $lightSettings');
        LightState lightState = LightState.getInstance();
        lightState.updateFromString(lightSettings);
        print(lightState);
      }).onDone(() {
        print('Disconnected by remote request');
      });

    }
    return _connection;
  }

  Future<BluetoothConnection> connectToSavedDevice() async {
    Map<String, dynamic> deviceParams =
        _sharedPreferencesService.getObject("bluetooth_device");
    if (deviceParams != null && deviceParams.isNotEmpty) {
      BluetoothDevice device = BluetoothDevice(
        name: deviceParams['name'].toString(),
        address: deviceParams['address'].toString(),
        type: BluetoothDeviceType.fromUnderlyingValue(
            int.parse(deviceParams['type'].toString())),
        isConnected: deviceParams['isConnected'].toString() == "true",
        bondState:
            BluetoothBondState.fromString(deviceParams['bondState'].toString()),
      );
      return await connect(device);
    }
    return _connection;
  }

  static BluetoothConnectionService instance() {
    if (_bluetoothConnectionService == null) {
      _bluetoothConnectionService = BluetoothConnectionService._();
    }
    return _bluetoothConnectionService;
  }

  BluetoothConnection get connection => _connection;

  BluetoothDevice get bluetoothDevice => _bluetoothDevice;
}
