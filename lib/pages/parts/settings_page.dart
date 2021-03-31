import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_light/enums/app_routes.dart';
import 'package:smart_light/service/shared_preferences_service.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {

  SharedPreferencesService _sharedPreferencesService;

  @override
  void initState() {
    super.initState();
    _sharedPreferencesService = SharedPreferencesService.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Налаштування'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Card(
              child: TextButton(
                onPressed: () {},
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  leading: Text(
                    "Підключення",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_right, size: 25,),
                ),
              ),
            ),
            ListTile(
              // contentPadding: EdgeInsets.symmetric(horizontal: 25),
              leading: TextButton(
                onPressed: () {
                  _sharedPreferencesService.clear();
                  Navigator.of(context).popAndPushNamed(AppRoutes.HOME);
                },
                child: Text(
                  "Вихід",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
