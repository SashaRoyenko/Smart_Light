import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class UtilService {

  // static Future<BluetoothCommandService> connectToBluetooth() async {
  //   BluetoothConnection connection = _bluetoothService.connection;
  //   // Future<BluetoothCommandService> _bluetoothCommandService;
  //   BluetoothCommandService _bluetoothCommandService =
  //       BluetoothCommandService(connection);

  //   if (connection == null || !connection.isConnected) {
  //     // _bluetoothService.connectToSavedDevice().then((value) {
  //     //   connection = value;
  //     //   if (value != null) {
  //     //     Fluttertoast.showToast(
  //     //         msg: "Під'єднано!",
  //     //         toastLength: Toast.LENGTH_SHORT,
  //     //         gravity: ToastGravity.BOTTOM,
  //     //         timeInSecForIosWeb: 2,
  //     //         backgroundColor: Colors.green,
  //     //         textColor: Colors.white,
  //     //         fontSize: 16.0);
  //     //   } else {
  //     //     throw Exception("Connection is null!");
  //     //   }
  //     // }).onError((error, stackTrace) {
  //     //   Fluttertoast.showToast(
  //     //       msg: "Не вдалося під'єднатися!",
  //     //       toastLength: Toast.LENGTH_SHORT,
  //     //       gravity: ToastGravity.BOTTOM,
  //     //       timeInSecForIosWeb: 2,
  //     //       backgroundColor: Colors.red,
  //     //       textColor: Colors.white,
  //     //       fontSize: 16.0);
  //     // });
  //     try {
  //       connection = await _bluetoothService.connectToSavedDevice();
  //       if (connection != null) {
  //         Fluttertoast.showToast(
  //             msg: "Під'єднано!",
  //             toastLength: Toast.LENGTH_SHORT,
  //             gravity: ToastGravity.BOTTOM,
  //             timeInSecForIosWeb: 2,
  //             backgroundColor: Colors.green,
  //             textColor: Colors.white,
  //             fontSize: 16.0);
  //       } else {
  //         throw Exception("Connection is null!");
  //       }
  //     } on Exception catch (e) {
  //       Fluttertoast.showToast(
  //           msg: "Не вдалося під'єднатися!",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 2,
  //           backgroundColor: Colors.red,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //     }
  //     return BluetoothCommandService(connection);
  //   } else {
  //     return _bluetoothCommandService;
  //   }
  // }

  // static loadFuture(var future, Function(dynamic) widget) {
  //   FutureBuilder(
  //     future: future,
  //     builder: (context, snapshot) {
  //       return snapshot.hasData
  //           ? widget(snapshot.data)
  //           : Center(
  //               child: SizedBox(
  //                 child: CircularProgressIndicator(),
  //                 width: 60,
  //                 height: 60,
  //               ),
  //             );
  //     },
  //   );
  // }
}
