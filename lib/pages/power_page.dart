import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_light/enums/app_routes.dart';

class PowerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PowerPageState();
}

class _PowerPageState extends State<PowerPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: IconButton(
          iconSize: 120,
          icon: Icon(
            Icons.power_settings_new_rounded,
            color: Colors.blue,
          ),
          onPressed: () {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.access_time),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.TIME);
        },
      ),
    );
  }
}
