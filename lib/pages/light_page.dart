import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_light/constants/constants.dart';
import 'package:smart_light/entity/LightSetting.dart';
import 'package:smart_light/entity/LightState.dart';
import 'package:smart_light/entity/Option.dart';
import 'package:smart_light/enums/app_routes.dart';
import 'package:smart_light/pages/parts/dialogs/dialogs_factory.dart';
import 'package:smart_light/service/arduino/ArduinoSocketService.dart';
import 'package:smart_light/service/arduino/mqtt_command_service.dart';
import 'package:smart_light/service/smart_light_service.dart';
import 'package:smart_light/utils/util_service.dart';

class LightPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LightPageState();
}

class _LightPageState extends State<LightPage> {
  final SmartLightService _smartLightService = new SmartLightService();
  LightSetting _lightSetting = LightSetting.name(
      color: Colors.amber, lightTemperature: 30, brightness: 70);
  ArduinoSocketService _arduinoSocketService = ArduinoSocketService();
  static final MQTTCommandService _mqttCommandService =
      MQTTCommandService.instance;
  bool _isRGBMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Consumer<LightState>(
        builder: (context, lightState, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.8,
                colors: !_isRGBMode
                    ? <Color>[
                        Color(0xffe8f4ff),
                        Color(0xffff8914),
                        // UtilService.colorTempToRGBFromTable(lightState.temperature),
                      ]
                    : <Color>[
                        Colors.white,
                        // Color(0xd53d71f6),
                        lightState.currentColor,
                      ],
                tileMode: TileMode.mirror,
              ),
            ),
            child: Stack(
              children: [
                _isRGBMode
                    ? Center(
                        child: CircleColorPicker(
                          initialColor: lightState.currentColor,
                          onChanged: (color) {
                            _mqttCommandService.light(color);
                            setState(() {
                              lightState.currentColor = color;
                            });
                          },
                          size: const Size(300, 300),
                          strokeWidth: 18,
                          thumbSize: 36,
                          textStyle: TextStyle(fontSize: 0),
                        ),
                      )
                    : Positioned(
                        left: 0,
                        right: 0,
                        bottom: 150,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100),
                          child: Column(
                            children: [
                              SliderTheme(
                                data: SliderThemeData(
                                  inactiveTickMarkColor: Colors.transparent,
                                  activeTickMarkColor: Colors.transparent,
                                  activeTrackColor: Colors.white,
                                  inactiveTrackColor: Colors.white70,
                                  thumbColor:
                                      UtilService.colorTempToRGBFromTable(
                                          lightState.temperature),
                                  valueIndicatorColor: Colors.transparent,
                                ),
                                child: Slider(
                                  value: lightState.temperature.toDouble(),
                                  min: MIN_COLOR_TEMPERATURE_VALUE,
                                  max: MAX_COLOR_TEMPERATURE_VALUE,
                                  divisions: ((MAX_COLOR_TEMPERATURE_VALUE -
                                              MIN_COLOR_TEMPERATURE_VALUE) /
                                          100)
                                      .round(),
                                  label: lightState.temperature.toString(),
                                  onChanged: (val) {
                                    // snapshot.data.brightness(val.toInt());
                                    setState(() {
                                      lightState.temperature = val.toInt();
                                    });
                                    // _mqttCommandService
                                    //     .temperature(val.toInt());
                                  },
                                  onChangeEnd: (val) {
                                    lightState.temperature = val.toInt();
                                    _mqttCommandService
                                        .temperature(val.toInt());
                                    // snapshot.data.brightness(val.toInt());
                                    // setState(() {});
                                  },
                                ),
                              ),
                              // Text(
                              //   "Колірна температура",
                              //   style: TextStyle(
                              //     fontSize: 18,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 250),
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Column(
                        children: [
                          SliderTheme(
                            data: SliderThemeData(
                              inactiveTickMarkColor: Colors.transparent,
                              activeTickMarkColor: Colors.transparent,
                              activeTrackColor: Colors.white,
                              inactiveTrackColor: Colors.white70,
                              thumbColor: Colors.white,
                              valueIndicatorColor: Colors.transparent,
                              valueIndicatorTextStyle: TextStyle(
                                color: Colors.transparent,
                              ),
                            ),
                            child: Slider(
                              value: lightState.brightness.toDouble(),
                              max: MAX_BRIGHTNESS_VALUE,
                              min: MIN_BRIGHTNESS_VALUE,
                              divisions: ((MAX_BRIGHTNESS_VALUE -
                                          MIN_BRIGHTNESS_VALUE) /
                                      5)
                                  .round(),
                              label: lightState.brightness.toString(),
                              onChanged: (val) {
                                setState(() {
                                  lightState.brightness = val.toInt();
                                });
                                // _mqttCommandService.brightness(val.toInt());
                              },
                              onChangeEnd: (val) {
                                // lightState.brightness = val.toInt();
                                _mqttCommandService.brightness(val.toInt());
                                // setState(() {});
                              },
                            ),
                          ),
                          // Text(
                          //   "Яскравість",
                          //   style: TextStyle(
                          //     fontSize: 18,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          iconSize: 35,
                          icon: Icon(
                            Icons.power_settings_new_rounded,
                            color: !lightState.isPowerOn
                                ? Colors.grey
                                : Colors.white70,
                          ),
                          onPressed: () {
                            lightState.isPowerOn = !lightState.isPowerOn;
                            _mqttCommandService
                                .power(lightState.isPowerOn ? 1 : 0);
                            setState(() {});
                          },
                        ),
                      ),
                      if (!_isRGBMode) ...[
                        MaterialButton(
                          onPressed: () {
                            // snapshot.data.auto();

                            setState(() {
                              lightState.isAuto = !lightState.isAuto;
                              _mqttCommandService
                                  .auto(lightState.isAuto ? 1 : 0);
                            });
                          },
                          // color: Colors.transparent,
                          textColor:
                              lightState.isAuto ? Colors.white : Colors.grey,
                          child: Text(
                            'АВТО',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          padding: EdgeInsets.all(20),
                          shape: CircleBorder(
                              side:
                                  BorderSide(width: 1, color: Colors.white70)),
                        ),
                      ],
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            colors: !_isRGBMode
                                ? <Color>[
                                    Colors.red,
                                    Colors.green,
                                    Colors.blue,
                                  ]
                                : <Color>[
                                    Color(0xffe8f4ff),
                                    Color(0xffff8914),
                                  ],
                          ),
                        ),
                        child: IconButton(
                          iconSize: 35,
                          icon: Icon(
                            Icons.light_mode,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _isRGBMode = !_isRGBMode;
                              if (_isRGBMode) {
                                _mqttCommandService
                                    .light(lightState.currentColor);
                              } else {
                                _mqttCommandService
                                    .temperature(lightState.temperature);
                              }
                            });
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          iconSize: 35,
                          icon: Icon(
                            Icons.access_time,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoutes.TIME);
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          iconSize: 35,
                          icon: Icon(
                            Icons.settings,
                            color: Colors.white70,
                          ),
                          onPressed: () => Navigator.of(context)
                              .pushNamed(AppRoutes.SETTINGS),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
    // } else {
    //   return Center(
    //     child: SizedBox(
    //       child: CircularProgressIndicator(),
    //       width: 60,
    //       height: 60,
    //     ),
    //   );
    // }
    // },
    // ),
    // );
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
