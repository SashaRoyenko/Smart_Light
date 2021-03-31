import 'package:flutter/material.dart';
import 'package:smart_light/pages/parts/settings_page.dart';

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserPageState();
}

class UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return SettingsPage();
  }
}
