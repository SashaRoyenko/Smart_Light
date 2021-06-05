import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_light/entity/AlarmSettings.dart';
import 'package:smart_light/entity/LightState.dart';
import 'package:smart_light/entity/Timer.dart';
import 'package:smart_light/pages/parts/dialogs/dialogs_factory.dart';
import 'package:smart_light/service/arduino/bluetooth_command_service.dart';
import 'package:smart_light/service/shared_preferences_service.dart';
import 'package:smart_light/service/util_service.dart';

class TimePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TimePageState();
}

class _TimePageState extends State<TimePage>
    with SingleTickerProviderStateMixin {
  int _tabIndex = 0;
  TabController _tabController;
  SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService.getInstance();
  List<TimerSetting> _timers = [];
  List<AlarmSettings> _alarms = [];
  List<Timer> startedTimers = [];

  Future<BluetoothCommandService> _bluetoothCommandService;

  @override
  void initState() {
    super.initState();
    initTimer();
    _tabController = TabController(length: 2, vsync: this);

    loadAlarmSettingsFromSharedPreferences();
    loadTimerSettingsFromSharedPreferences();
    initTimer();

    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
    });
    _bluetoothCommandService = UtilService.connectToBluetooth();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BluetoothCommandService>(
      future: _bluetoothCommandService,
      builder: (context, snapshot) {
        // return snapshot.hasData
        //     ?
        return _mainWidget(snapshot.data);
            // : Center(
            //     child: SizedBox(
            //       child: CircularProgressIndicator(),
            //       width: 60,
            //       height: 60,
            //     ),
            //   );
      },
    );
  }

  Widget _mainWidget(BluetoothCommandService data) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Режим увімкнення'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: "Таймер",
              icon: Icon(Icons.timer),
            ),
            Tab(
              text: "Будильник",
              icon: Icon(Icons.alarm),
            ),
          ],
        ),
      ),
      body: Consumer<LightState>(builder: (context, lightState, child) {
        AlarmSettings alarmSettings = AlarmSettings.name(lightState.alarmTime, lightState.isAlarm);
        if(_alarms.length < 1) {
          _alarms.add(alarmSettings);
        }  else {
          _alarms[0] = alarmSettings;
        }
        return TabBarView(
          controller: _tabController,
          children: [
            _timers.length > 0
                ? Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 120),
                        ),
                        Text(
                          _timers[0].isTurnOn
                              ? 'Часу залишилося до увімкнення:'
                              : 'Часу залишилося до відключення: ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 50)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _timers[0].time.hour.toString(),
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' : ',
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _timers[0].time.minute.toString(),
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' : ',
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _timers[0].time.second.toString(),
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : Container(),
            ListView.builder(
              itemCount: _alarms.length,
              itemBuilder: (context, index) => Container(
                child: Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 25),
                    leading: Text(
                      DateFormat('HH:mm').format(_alarms[index].time),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Switch(
                      value: _alarms[index].isActive,
                      onChanged: (bool value) {
                        setState(() {
                          _alarms[index].isActive = value;
                          if (value) {
                            data.alarm(_alarms[index].time);
                          } else {
                            data.stopAlarm();
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
      floatingActionButton:
          Consumer<LightState>(builder: (context, lightState, child) {
        return FloatingActionButton(
          onPressed: () {
            if (_tabIndex == 0) {
              DialogsFactory.showTimerDialog(context, (timerSetting) {
                setState(() {
                  if (_timers.length > 0) {
                    _timers[0] = timerSetting;
                  } else {
                    _timers.add(timerSetting);
                  }
                  _startTimer(timerSetting);
                  data.timer(timerSetting.time, timerSetting.isTurnOn ? 1 : 0);
                });
              });
            } else {
              DialogsFactory.showAlarmDialog(context, lightState.alarmTime,
                  (alarmSettings) {
                setState(() {
                  if (_alarms.length > 0) {
                    _alarms[0] = alarmSettings;
                  } else {
                    _alarms.add(alarmSettings);
                  }
                  var json = _alarms.map((e) => e.toJson()).toList();
                  _sharedPreferencesService.putObject("alarm", json);
                  data.alarm(alarmSettings.time);
                });
              });
            }
          },
          child: Icon(
            _tabIndex == 0 ? Icons.timer : Icons.add_alarm,
            size: 40,
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    startedTimers.forEach((element) => element.cancel());
    saveTimerSettingsToSharedPreferences();
  }

  void initTimer() {
    setState(() {
      _timers.forEach((element) {
        _startTimer(element);
      });
    });
  }

  void _startTimer(TimerSetting element) {
    Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (element.time.second > 0 ||
            element.time.minute > 0 ||
            element.time.hour > 0) {
          element.time = element.time.add(Duration(seconds: -1));
        } else {
          _timers.remove(element);
          timer.cancel();
          saveTimerSettingsToSharedPreferences();
        }
      });
    });
    startedTimers.add(timer);
  }

  void saveTimerSettingsToSharedPreferences() {
    var json = _timers.map((e) => e.toJson()).toList();
    _sharedPreferencesService.putObject("timer", json);
  }

  void loadAlarmSettingsFromSharedPreferences() {
    var sharedPreferencesAlarm = _sharedPreferencesService.getObjects("alarm");
    _alarms = sharedPreferencesAlarm == null
        ? []
        : sharedPreferencesAlarm
            .map<AlarmSettings>((e) => AlarmSettings.fromJson(e))
            .toList();
  }

  void loadTimerSettingsFromSharedPreferences() {
    var sharedPreferencesTimer = _sharedPreferencesService.getObjects("timer");
    _timers = sharedPreferencesTimer == null
        ? []
        : sharedPreferencesTimer
            .map<TimerSetting>((e) {
              var timerSettings = TimerSetting.fromJson(e);

              DateTime currentTime = DateTime.now();
              DateTime validityTime = timerSettings.validityTime;

              DateTime currentTimerValue =
                  timerSettings.time = validityTime.subtract(Duration(
                hours: currentTime.hour,
                minutes: currentTime.minute,
                seconds: currentTime.second,
              ));
              timerSettings.time = currentTimerValue;

              return timerSettings;
            })
            .where((element) => element.time.day >= DateTime.now().day)
            .toList();
  }
}
