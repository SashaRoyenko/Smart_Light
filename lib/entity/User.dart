import 'dart:convert';

import 'package:smart_light/entity/LightSetting.dart';
import 'package:smart_light/entity/Option.dart';

class User {
  String email;
  String firstName;
  String lastName;
  LightSetting lightSetting;
  List<Option> options;
  int id;

  User.name(
      {this.email,
      this.firstName,
      this.lastName,
      this.lightSetting,
      this.options,
      this.id});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          lightSetting == other.lightSetting &&
          options == other.options &&
          id == other.id;

  @override
  int get hashCode =>
      email.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      lightSetting.hashCode ^
      options.hashCode ^
      id.hashCode;

  @override
  String toString() {
    return 'User{email: $email, firstName: $firstName, lastName: $lastName, lightSetting: $lightSetting, options: $options, id: $id}';
  }

  static User fromJson(Map<String, dynamic> json) {
    List<Option> options =
        (json['options'] as List).map((e) => Option.fromJson(e)).toList();

    return User.name(
      id: json['id'],
      email: json['email'],
      options: options,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'options': options.map((e) => e.toJson()).toList(),
      };
}
