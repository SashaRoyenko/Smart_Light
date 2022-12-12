import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_light/entity/CreateAccountDto.dart';
import 'package:smart_light/entity/Login.dart';
import 'package:smart_light/entity/Option.dart';
import 'package:smart_light/service/shared_preferences_service.dart';

class SmartLightService {
  static const String MAIN_URL = "http://192.168.0.191:5624/smart-light";
  static const String LOGIN_URL = MAIN_URL + "/login";
  static const String USER_URL = MAIN_URL + "/users";
  static const String USER_OPTION_URL = USER_URL + "/options";
  static SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService.getInstance();

  Future<dynamic> login(Login login) async {
    var body = jsonEncode(
        <String, String>{"email": login.email, "password": login.password});

    Uri uri = Uri.parse(LOGIN_URL);
    var response = await http.post(
      uri,
      body: body,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  Future<dynamic> createAccount(CreateAccountDto createAccountDto) async {
    var body = jsonEncode(createAccountDto.toJson());
    Uri uri = Uri.parse(USER_URL);
    var response = await http.post(
      uri,
      body: body,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  Future<dynamic> saveOption(Option option) async {
    String token = _sharedPreferencesService.getString("token");
    var body = jsonEncode(option.toJson());
    Uri uri = Uri.parse(USER_OPTION_URL);

    var response = await http.post(
      uri,
      body: body,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    return response;
  }

  Future<List<Option>> getOptions() async {
    String token = _sharedPreferencesService.getString("token");

    Uri uri = Uri.parse(USER_OPTION_URL);

    var response = await http.get(
      uri,
      headers: <String, String>{
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map<Option>((e) => Option.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }
}
