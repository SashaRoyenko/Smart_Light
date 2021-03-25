import 'package:flutter/cupertino.dart';
import 'package:smart_light/entity/AlarmSettings.dart';
import 'package:smart_light/entity/Timer.dart';
import 'package:smart_light/pages/parts/dialogs/option_dialog.dart';
import 'package:smart_light/pages/parts/dialogs/timer_dialog.dart';

import 'alarm_dialog.dart';

class DialogsFactory {
  _DialogsFactory(){

  }

  static void showSaveOptionDialog(BuildContext context, Function(String) callback) {
    OptionDialog(context, callback).showOptionDialog();
  }

  static void showAlarmDialog(BuildContext context, Function(AlarmSettings) callback) {
    AlarmDialog(context, callback).showAlarmDialog();
  }

  static void showTimerDialog(BuildContext context, Function(TimerSetting) callback) {
    TimerDialog(context, callback).showTimerDialog();
  }

}