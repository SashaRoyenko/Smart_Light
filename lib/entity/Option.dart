import 'LightSetting.dart';

class Option {
  String name;
  LightSetting lightSetting;

  Option();

  Option.name({this.name, this.lightSetting});

  static Option fromJson(Map<String, dynamic> json) {
    return Option.name(
      name: json['name'],
      lightSetting: LightSetting.fromJson(json['lightSetting']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'lightSetting': lightSetting.toJson(),
      };
}
