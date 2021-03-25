import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_light/enums/app_routes.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
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
                        if (_formKey.currentState.validate()) {}
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
}
