import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_light/entity/LightSetting.dart';
import 'package:smart_light/entity/Option.dart';
import 'package:smart_light/enums/app_routes.dart';
import 'package:smart_light/pages/parts/dialogs/dialogs_factory.dart';
import 'package:smart_light/service/arduino/ArduinoSocketService.dart';
import 'package:smart_light/service/arduino/bluetooth_command_service.dart';
import 'package:smart_light/service/bluetooth_connection_service.dart';
import 'package:smart_light/service/smart_light_service.dart';

class LightPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LightPageState();
}

class _LightPageState extends State<LightPage> {
  final SmartLightService _smartLightService = new SmartLightService();
  LightSetting _lightSetting = LightSetting.name(
      color: Colors.amber, lightTemperature: 30, brightness: 70);
  ArduinoSocketService _arduinoSocketService = ArduinoSocketService();

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
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(
                Icons.favorite_border,
                size: 35,
              ),
              onPressed: () => _saveOption(),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 200),
              child: CircleColorPicker(
                initialColor: _lightSetting.color,
                onChanged: (color) {
                  _lightSetting.color = color;
                  // _arduinoSocketService.sendColor(color);
                  _bluetoothCommandService.color(color);
                },
                size: const Size(300, 300),
                strokeWidth: 18,
                thumbSize: 36,
                textStyle: TextStyle(fontSize: 0),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            // top: 150,
            bottom: 180,
            child: Column(
              children: [
                SliderTheme(
                  data: SliderThemeData(),
                  child: Slider(
                    value: _lightSetting.lightTemperature.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 20,
                    label: _lightSetting.lightTemperature.toString(),
                    onChanged: (val) {
                      _lightSetting.lightTemperature = val.toInt();
                      // _currentTemperatureValue = val;
                      setState(() {});
                    },
                  ),
                ),
                Text(
                  "Яскравість",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            // top: 100,
            left: 0,
            right: 0,
            bottom: 100,
            child: Column(
              children: [
                SliderTheme(
                  data: SliderThemeData(),
                  child: Slider(
                    value: _lightSetting.brightness.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 20,
                    label: _lightSetting.brightness.round().toString(),
                    onChanged: (val) {
                      _lightSetting.brightness = val.toInt();
                      setState(() {});
                    },
                  ),
                ),
                Text(
                  "Температура",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.OPTIONS);
        },
        child: Icon(Icons.format_list_bulleted_sharp, size: 35),
      ),
    );
  }

  void _saveOption() {
    DialogsFactory.showSaveOptionDialog(context, (value) async {
      Option option = Option()
        ..name = value
        ..lightSetting = _lightSetting;
      var response = await _smartLightService.saveOption(option);
      if (response.statusCode == 200) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _arduinoSocketService.endConnection();
  }
}
