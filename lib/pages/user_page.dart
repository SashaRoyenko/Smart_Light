import 'package:flutter/material.dart';
import 'package:smart_light/pages/authoriztion/login_page.dart';
import 'package:smart_light/pages/parts/settings_page.dart';

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserPageState();
}

class UserPageState extends State<UserPage> {
  bool isUserPresent = false;
  @override
  Widget build(BuildContext context) {
    return isUserPresent ? SettingsPage() : LoginPage();
  }
}
