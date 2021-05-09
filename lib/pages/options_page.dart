import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_light/entity/Option.dart';
import 'package:smart_light/service/arduino/bluetooth_command_service.dart';
import 'package:smart_light/service/bluetooth_connection_service.dart';
import 'package:smart_light/service/smart_light_service.dart';

class OptionsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  Future<List<Option>> _options;
  SmartLightService _smartLightService = SmartLightService();

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
      _getOptions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Режими'),
      ),
      body: FutureBuilder<List<Option>>(
          future: _options,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Option> options = snapshot.data;
              return GridView.builder(
                itemCount: options.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                padding: EdgeInsets.all(5),
                itemBuilder: (BuildContext context, int index) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          options[index].lightSetting.color),
                    ),
                    onPressed: () {
                      _bluetoothCommandService.color(options[index].lightSetting.color);
                    },
                    child: Center(
                      child: new GridTile(
                        child: new Text(options[index].name),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text('Error: ${snapshot.error}'),
                    )
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
          }),
    );
  }

  void _getOptions() async {
    _options = _smartLightService.getOptions();
  }
}
