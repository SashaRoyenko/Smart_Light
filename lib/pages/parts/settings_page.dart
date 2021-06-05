import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_light/entity/LightState.dart';
import 'package:smart_light/enums/app_routes.dart';
import 'package:smart_light/service/arduino/bluetooth_command_service.dart';
import 'package:smart_light/service/shared_preferences_service.dart';
import 'package:smart_light/service/util_service.dart';

import 'dialogs/dialogs_factory.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  SharedPreferencesService _sharedPreferencesService;
  Future<BluetoothCommandService> _bluetoothCommandService;

  @override
  void initState() {
    super.initState();
    _sharedPreferencesService = SharedPreferencesService.getInstance();
    _bluetoothCommandService = UtilService.connectToBluetooth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Налаштування'),
      ),
      body: FutureBuilder<BluetoothCommandService>(
          future: _bluetoothCommandService,
          builder: (context, snapshot) {
            // if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    Card(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.BLUETOOTH_DEVICES);
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          leading: Text(
                            "Підключення",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_right,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Consumer<LightState>(
                          builder: (context, lightState, child) {
                        return TextButton(
                          onPressed: () {
                            DialogsFactory.showAlarmDialog(
                                context, lightState.currentTime,
                                (alarmSettings) {
                              snapshot.data.time(alarmSettings.time);
                            });
                          },
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            leading: Text(
                              "Встановити час",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_right,
                              size: 25,
                            ),
                          ),
                        );
                      }),
                    ),
                    // Card(
                    //   child: TextButton(
                    //     onPressed: () {
                    //         snapshot.data.read();
                    //     },
                    //     child: ListTile(
                    //       contentPadding:
                    //       EdgeInsets.symmetric(horizontal: 20),
                    //       leading: Text(
                    //         "Test data receiving",
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
                    ListTile(
                      // contentPadding: EdgeInsets.symmetric(horizontal: 25),
                      leading: TextButton(
                        onPressed: () {
                          _sharedPreferencesService.clear();
                          Navigator.of(context).popAndPushNamed(AppRoutes.HOME);
                        },
                        child: Text(
                          "Вихід",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
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
          }),
    );
  }
}
