import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_light/entity/AlarmSettings.dart';
import 'package:smart_light/entity/Timer.dart';
import 'package:smart_light/pages/parts/dialogs/dialogs_factory.dart';

class TimePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TimePageState();
}

class _TimePageState extends State<TimePage>
    with SingleTickerProviderStateMixin {
  int _tabIndex = 0;
  TabController _tabController;
  List<TimerSetting> _timers = [];
  List<AlarmSettings> _alarms = [];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
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
              });
            });
          } else {
            DialogsFactory.showAlarmDialog(context, (alarmSettings) {
              setState(() {
                _alarms.add(alarmSettings);
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
  }
}
