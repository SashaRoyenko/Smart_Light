import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothConnectionService {
  BluetoothDevice _bluetoothDevice;
  BluetoothConnection _connection;
  static BluetoothConnectionService _bluetoothConnectionService;

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
      _connection = await BluetoothConnection.toAddress(device.address);
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
