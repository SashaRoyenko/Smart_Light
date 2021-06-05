import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_light/entity/LightState.dart';
import 'package:smart_light/pages/home_page.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => LightState.getInstance(),
        child: HomePage(),
      ),
    );
