import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:smart_light/entity/AlarmSettings.dart';

class AlarmDialog {
  final BuildContext _context;
  final Function(AlarmSettings) _onSubmit;

  AlarmDialog(this._context, this._onSubmit);

  void showAlarmDialog() {
    DatePicker.showTimePicker(
      _context,
      showTitleActions: true,
      onConfirm: (date) {
        print(date);
        AlarmSettings alarmSettings = AlarmSettings()
        ..isActive = true
        ..time = date;
        _onSubmit(alarmSettings);
      },
      currentTime: DateTime.utc(DateTime.now().year),
      showSecondsColumn: false,
      locale: LocaleType.ru,
    );
  }
}