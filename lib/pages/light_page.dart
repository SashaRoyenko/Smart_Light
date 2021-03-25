import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:smart_light/enums/app_routes.dart';
import 'package:smart_light/pages/parts/dialogs/dialogs_factory.dart';

class LightPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LightPageState();
}

class _LightPageState extends State<LightPage> {
  double _currentTemperatureValue = 20;
  double _currentBrightnessValue = 20;

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
              onPressed: () => {
                DialogsFactory.showSaveOptionDialog(context, (value) => null)
              },
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
                initialColor: Colors.blue,
                onChanged: (color) => print(color),
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
                    value: _currentTemperatureValue,
                    min: 0,
                    max: 100,
                    divisions: 20,
                    label: _currentTemperatureValue.round().toString(),
                    onChanged: (val) {
                      _currentTemperatureValue = val;
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
                    value: _currentBrightnessValue,
                    min: 0,
                    max: 100,
                    divisions: 20,
                    label: _currentBrightnessValue.round().toString(),
                    onChanged: (val) {
                      _currentBrightnessValue = val;
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
}
