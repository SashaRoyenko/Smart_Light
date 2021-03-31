import 'dart:ui';

import 'package:smart_light/utils/util_service.dart';

class LightSetting {
  Color color;
  int id;
  int lightTemperature;
  int brightness;

  LightSetting();

  LightSetting.name(
      {this.color, this.id, this.lightTemperature, this.brightness});

  static LightSetting fromJson(Map<String, dynamic> json) {
    return LightSetting.name(
      id: json['id'],
      color: Color(int.parse(json['color'].toString())),
      lightTemperature: json['lightTemperature'],
      brightness: json['brightness'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'color': color.value,
        'lightTemperature': lightTemperature,
        'brightness': brightness,
      };
}
