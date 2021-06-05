import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:smart_light/entity/AlarmSettings.dart';

class AlarmDialog {
  final BuildContext _context;
  final Function(AlarmSettings) _onSubmit;
  final DateTime _currentTime;
  AlarmDialog(this._context, this._onSubmit, this._currentTime);

  void showAlarmDialog() {
    DatePicker.showTimePicker(
      _context,
      showTitleActions: true,
      onConfirm: (date) {
        AlarmSettings alarmSettings = AlarmSettings()
          ..isActive = true
          ..time = date;

        _onSubmit(alarmSettings);
      },
      currentTime: _currentTime,
      showSecondsColumn: false,
      locale: LocaleType.ru,
    );
  }
}
