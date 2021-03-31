import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_light/entity/User.dart';
import 'package:smart_light/pages/light_page.dart';
import 'package:smart_light/pages/parts/bottom_navigation.dart';
import 'package:smart_light/pages/power_page.dart';
import 'package:smart_light/pages/user_page.dart';
import 'package:smart_light/service/shared_preferences_service.dart';
import 'package:smart_light/utils/route_generator.dart';

import 'authoriztion/login_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Widget> pages = [PowerPage(), LightPage(), UserPage()];
  int _currentIndex = 0;
  Future<SharedPreferencesService> _sharedPreferencesService =
      SharedPreferencesService.getInstanceAsync();

  User _user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _sharedPreferencesService,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var result = snapshot.data.getObject("user");
            if (result != null) {
              _user = User.fromJson(result);
            } else {
              _user = null;
            }
            return _user != null
                ? Scaffold(
                    body: pages[_currentIndex],
                    bottomNavigationBar:
                        BottomNavigation(notifyParent: getCurrentIndex),
                  )
                : LoginPage(
                    updateParentCallback: () => setState(
                      () {
                        _currentIndex = 0;
                      },
                    ),
                  );
          } else {
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
            );
          }
        },
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
