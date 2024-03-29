import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_light/entity/CreateAccountDto.dart';
import 'package:smart_light/enums/gender.dart';
import 'package:smart_light/service/smart_light_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SmartLightService smartLightService = SmartLightService();

  // static SharedPreferencesService _sharedPreferencesService;
  String _email;
  Gender _gender;
  int _age;
  String _firstPassword;
  String _secondPassword;
  String _exceptionMessage = '';

  // @override
  // void initState() {
  //   super.initState();
  //   _sharedPreferencesService = SharedPreferencesService.getInstance();
  // }

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
                    padding: const EdgeInsets.only(top: 25),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: 150),
                          child: DropdownButtonFormField(
                            value: _age,
                            hint: Text(
                              'Оберіть вік',
                            ),
                            isExpanded: true,
                            items: List.generate(
                              100,
                              (index) => DropdownMenuItem(
                                value: index + 1,
                                child: Text(
                                  (index + 1).toString(),
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              _age = value;
                            },
                            validator: (int value) {
                              if (value == null) {
                                return 'Поле не може бути пустим';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: 150),
                          child: DropdownButtonFormField(
                            value: _gender,
                            hint: Text(
                              'Оберіть стать',
                            ),
                            isExpanded: true,
                            items: <DropdownMenuItem>[
                              DropdownMenuItem(
                                value: Gender.MALE,
                                child: Text(
                                  "Чоловік",
                                ),
                              ),
                              DropdownMenuItem(
                                value: Gender.FEMALE,
                                child: Text(
                                  "Жінка",
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              _gender = value;
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Поле не може бути пустим';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Пароль",
                      ),
                      validator: (String value) {
                        if (value == null || value.isEmpty) {
                          return 'Поле не може бути пустим';
                        }
                        _firstPassword = value;
                        return null;
                      },
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Підтвердіть пароль",
                    ),
                    validator: (String value) {
                      if (value == null || value.isEmpty) {
                        return 'Поле не може бути пустим';
                      }
                      _secondPassword = value;
                      if (_firstPassword != _secondPassword) {
                        return 'Паролі не співпадають';
                      }
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
                      child: Text(
                        'Зареєструватися',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _register();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.blue),
                        minimumSize: MaterialStateProperty.resolveWith(
                          (states) => Size.fromHeight(50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _register() async {
    CreateAccountDto createAccountDto = CreateAccountDto()
      ..email = _email
      ..age = _age
      ..gender = _gender
      ..password = _secondPassword;
    var response = await smartLightService.createAccount(createAccountDto);
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        _exceptionMessage = jsonDecode(response.body)['message'] == null
            ? "Не вдалося зареєструвати"
            : jsonDecode(response.body)['message'];
      });
    }
  }
}
