import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_light/entity/Timer.dart';

class TimerDialog {
  final BuildContext _context;
  final Function(TimerSetting) _onSubmit;

  bool _isTurnOn = false;
  Duration _duration;

  TimerDialog(this._context, this._onSubmit);

  void showTimerDialog() {
    showDialog<String>(
      context: _context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: SizedBox(
              width: 500,
              height: 300,
              child: new Column(
                children: <Widget>[
                  CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hms,
                    minuteInterval: 1,
                    secondInterval: 1,
                    onTimerDurationChanged: (Duration duration) {
                      setState(() {
                        _duration = duration;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Вимкнути'),
                        Switch(
                          value: _isTurnOn,
                          onChanged: (value) {
                            setState(() {
                              _isTurnOn = value;
                            });
                          },
                          activeTrackColor: Colors.yellow,
                          activeColor: Colors.orangeAccent,
                        ),
                        Text('Увімкнути')
                      ],
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              new TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    TimerSetting timerSetting = TimerSetting()
                      ..isTurnOn = _isTurnOn
                      ..timeFromDuration = _duration;
                    _onSubmit(timerSetting);
                    Navigator.pop(context);
                  })
            ],
          );
        });
      },
    );
  }
}
