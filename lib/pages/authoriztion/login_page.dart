import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_light/entity/Login.dart';
import 'package:smart_light/entity/User.dart';
import 'package:smart_light/enums/app_routes.dart';
import 'package:smart_light/service/shared_preferences_service.dart';
import 'package:smart_light/service/smart_light_service.dart';

class LoginPage extends StatefulWidget {
  final Function() updateParentCallback;

  LoginPage({this.updateParentCallback});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SmartLightService smartLightService = SmartLightService();
  static SharedPreferencesService _sharedPreferencesService;

  String _exceptionMessage = '';
  String _email;
  String _password;

  @override
  void initState() {
    _sharedPreferencesService = SharedPreferencesService.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'authorization_icon',
              child: Icon(
                Icons.account_circle,
                size: 65,
                color: Colors.blue,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Електронна адреса",
                      ),
                      validator: (String value) {
                        if (value == null || value.isEmpty) {
                          return 'Поле не може бути пустим';
                        }
                        _email = value;
                        return null;
                      },
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Пароль",
                    ),
                    validator: (String value) {
                      if (value == null || value.isEmpty) {
                        return 'Поле не може бути пустим';
                      }
                      _password = value;
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      _exceptionMessage,
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Увійти',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.login,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _login();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.green),
                        minimumSize: MaterialStateProperty.resolveWith(
                          (states) => Size.fromHeight(50),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'Створити акаунт',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.REGISTER);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login() async {
    Login login = Login()
      ..password = _password
      ..email = _email;
    var response = await smartLightService.login(login);
    if (response.statusCode == 200) {
      User user = User.fromJson(jsonDecode(response.body));
      _sharedPreferencesService.putObject("user", user);
      _sharedPreferencesService.putString(
          "token", response.headers['authorization']);
      _exceptionMessage = '';
      widget.updateParentCallback();
      Navigator.of(context).popAndPushNamed(AppRoutes.HOME);
    } else if (response.statusCode > 400 && response.statusCode < 500) {
      setState(() {
        // _exceptionMessage = jsonDecode(response.body)['message'];
        _exceptionMessage = "Перевірте правильність даних!";
      });
    } else {
      _exceptionMessage = "Сервер не відповідає, будь ласка спробуйте пізніше";
    }
  }
}
