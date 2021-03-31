import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_light/entity/AlarmSettings.dart';
import 'package:smart_light/entity/Timer.dart';
import 'package:smart_light/pages/parts/dialogs/dialogs_factory.dart';
import 'package:smart_light/service/shared_preferences_service.dart';

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
  }

  @override
  Widget build(BuildContext context) {
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
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            itemCount: _timers.length,
            itemBuilder: (context, index) => Container(
              child: Card(
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  title: Text(
                    _timers[index].isTurnOn
                        ? 'Час залишилося до увімкнення:'
                        : 'Час залишилося до відключення: ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  trailing: Text(
                    DateFormat('HH:mm:ss').format(_timers[index].time),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
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
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_tabIndex == 0) {
            DialogsFactory.showTimerDialog(context, (timerSetting) {
              setState(() {
                _timers.add(timerSetting);
                _startTimer(timerSetting);
              });
            });
          } else {
            DialogsFactory.showAlarmDialog(context, (alarmSettings) {
              setState(() {
                _alarms.add(alarmSettings);
                var json = _alarms.map((e) => e.toJson()).toList();
                _sharedPreferencesService.putObject("alarm", json);
              });
            });
          }
        },
        child: Icon(
          _tabIndex == 0 ? Icons.timer : Icons.add_alarm,
          size: 40,
        ),
      ),
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
        : sharedPreferencesTimer.map<TimerSetting>((e) {
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
          }).toList();
  }
}
