import 'package:flutter/material.dart';
import 'package:smart_light/enums/app_routes.dart';
import 'package:smart_light/pages/authoriztion/login_page.dart';
import 'package:smart_light/pages/authoriztion/register_page.dart';
import 'package:smart_light/pages/devices_page.dart';
import 'package:smart_light/pages/home_page.dart';
import 'package:smart_light/pages/options_page.dart';
import 'package:smart_light/pages/parts/settings_page.dart';
import 'package:smart_light/pages/time_page.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.HOME:
        return MaterialPageRoute(builder: (_) => HomePage());
      case AppRoutes.TIME:
        return MaterialPageRoute(builder: (_) => TimePage());
      case AppRoutes.OPTIONS:
        return MaterialPageRoute(builder: (_) => OptionsPage());
      case AppRoutes.LOGIN:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case AppRoutes.REGISTER:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case AppRoutes.SETTINGS:
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case AppRoutes.DEVICES:
        return MaterialPageRoute(builder: (_) => DevicesPage());
      default:
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }
}
