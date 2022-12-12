import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_light/entity/LightState.dart';
import 'package:smart_light/enums/app_routes.dart';
import 'package:smart_light/service/arduino/mqtt_command_service.dart';
import 'package:smart_light/service/shared_preferences_service.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  SharedPreferencesService _sharedPreferencesService;
  static final MQTTCommandService _mqttCommandService =
      MQTTCommandService.instance;

  List<int> utcList = [];

  @override
  void initState() {
    super.initState();
    _sharedPreferencesService = SharedPreferencesService.getInstance();
    for (int i = -12; i <= 14; i++) {
      utcList.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        elevation: 0,
        title: Text('Налаштування'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.8,
            colors: <Color>[
              Colors.white,
              Color(0xe43f64e1),
              Color(0xec073ad2),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Consumer<LightState>(builder: (context, lightState, child) {
            return ListView(
              children: [
                // Card(
                //   child: TextButton(
                //     onPressed: () {
                //       DialogsFactory.showAlarmDialog(
                //           context, lightState.currentTime, (alarmSettings) {
                //         // snapshot.data.time(alarmSettings.time);
                //       });
                //     },
                //     child: ListTile(
                //       contentPadding: EdgeInsets.symmetric(horizontal: 20),
                //       leading: Text(
                //         "Встановити час",
                //         style: TextStyle(
                //           fontSize: 16,
                //         ),
                //       ),
                //       trailing: Icon(
                //         Icons.arrow_right,
                //         size: 25,
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.DEVICES);
                      },
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.only(left: -10, top: 0, bottom: 0),
                        leading: Text(
                          "Пристрої",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_right,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  child: DropdownButtonFormField(
                    value: lightState.utc,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    dropdownColor: Colors.white,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    items: utcList.map((int item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text("UTC " +
                            (item > 0
                                ? "+" + item.toString()
                                : item.toString())),
                      );
                    }).toList(),
                    onChanged: (int newValue) {
                      _mqttCommandService.utc(newValue);
                      setState(() {
                        lightState.utc = newValue;
                      });
                    },
                  ),
                ),
                ListTile(
                  // contentPadding: EdgeInsets.symmetric(horizontal: 25),
                  leading: ElevatedButton(
                    onPressed: () {
                      _sharedPreferencesService.clear();
                      Navigator.of(context).popAndPushNamed(AppRoutes.HOME);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.redAccent),
                    ),
                    child: Text(
                      "Вихід",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
