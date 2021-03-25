import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_light/pages/light_page.dart';
import 'package:smart_light/pages/parts/bottom_navigation.dart';
import 'package:smart_light/pages/power_page.dart';
import 'package:smart_light/pages/user_page.dart';
import 'package:smart_light/utils/route_generator.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Widget> pages = [PowerPage(), LightPage(), UserPage()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNavigation(notifyParent: getCurrentIndex),
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }

  void getCurrentIndex(int childIndex) {
    setState(() {
      _currentIndex = childIndex;
    });
  }
}
