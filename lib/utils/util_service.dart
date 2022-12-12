import 'dart:math';

import 'package:flutter/material.dart';

class UtilService {
  static loadFuture(var future, Function(dynamic) widget) {
    FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? widget(snapshot.data)
            : Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
              );
      },
    );
  }

  static int checkMeasures(int value, int min, int max) {
    if (value < min) {
      return min;
    }
    if (value > max) {
      return max;
    }
    return value;
  }

  static Color getColorFromHex(String color) {
    String colorHex = color.replaceAll("Color(", "");
    colorHex = colorHex.replaceAll(")", "");
    return Color(int.parse(colorHex));
  }

  static void addTimeDateTime(DateTime value, DateTime timeToAdd) {}

  static Color colorTempToRGB(double colorTemp) {
    final temp = colorTemp / 100;

    final red = temp <= 66
        ? 255
        : (pow(temp - 60, -0.1332047592) * 329.698727446).round().clamp(0, 255);

    final green = temp <= 66
        ? (99.4708025861 * log(temp) - 161.1195681661).round().clamp(0, 255)
        : (pow(temp - 60, -0.0755148492) * 288.1221695283)
            .round()
            .clamp(0, 255);

    final blue = temp >= 66
        ? 255
        : temp <= 19
            ? 0
            : (138.5177312231 * log(temp - 10) - 305.0447927307)
                .round()
                .clamp(0, 255);

    return Color.fromARGB(100, red, green, blue);
  }

  static Color colorTempToRGBFromTable(int colorTemp) {
    return colorTemperatureMap[colorTemp];
  }

  static const colorTemperatureMap = {
    1000: Color.fromRGBO(255, 56, 0, 1.0),
    1100: Color.fromRGBO(255, 71, 0, 1.0),
    1200: Color.fromRGBO(255, 83, 0, 1.0),
    1300: Color.fromRGBO(255, 93, 0, 1.0),
    1400: Color.fromRGBO(255, 101, 0, 1.0),
    1500: Color.fromRGBO(255, 109, 0, 1.0),
    1600: Color.fromRGBO(255, 115, 0, 1.0),
    1700: Color.fromRGBO(255, 121, 0, 1.0),
    1800: Color.fromRGBO(255, 126, 0, 1.0),
    1900: Color.fromRGBO(255, 131, 0, 1.0),
    2000: Color.fromRGBO(255, 138, 18, 1.0),
    2100: Color.fromRGBO(255, 142, 33, 1.0),
    2200: Color.fromRGBO(255, 147, 44, 1.0),
    2300: Color.fromRGBO(255, 152, 54, 1.0),
    2400: Color.fromRGBO(255, 157, 63, 1.0),
    2500: Color.fromRGBO(255, 161, 72, 1.0),
    2600: Color.fromRGBO(255, 165, 79, 1.0),
    2700: Color.fromRGBO(255, 169, 87, 1.0),
    2800: Color.fromRGBO(255, 173, 94, 1.0),
    2900: Color.fromRGBO(255, 177, 101, 1.0),
    3000: Color.fromRGBO(255, 180, 107, 1.0),
    3100: Color.fromRGBO(255, 184, 114, 1.0),
    3200: Color.fromRGBO(255, 187, 120, 1.0),
    3300: Color.fromRGBO(255, 190, 126, 1.0),
    3400: Color.fromRGBO(255, 193, 132, 1.0),
    3500: Color.fromRGBO(255, 196, 137, 1.0),
    3600: Color.fromRGBO(255, 199, 143, 1.0),
    3700: Color.fromRGBO(255, 201, 148, 1.0),
    3800: Color.fromRGBO(255, 204, 153, 1.0),
    3900: Color.fromRGBO(255, 206, 159, 1.0),
    4000: Color.fromRGBO(255, 209, 163, 1.0),
    4100: Color.fromRGBO(255, 211, 168, 1.0),
    4200: Color.fromRGBO(255, 213, 173, 1.0),
    4300: Color.fromRGBO(255, 215, 177, 1.0),
    4400: Color.fromRGBO(255, 217, 182, 1.0),
    4500: Color.fromRGBO(255, 219, 186, 1.0),
    4600: Color.fromRGBO(255, 221, 190, 1.0),
    4700: Color.fromRGBO(255, 223, 194, 1.0),
    4800: Color.fromRGBO(255, 225, 198, 1.0),
    4900: Color.fromRGBO(255, 227, 202, 1.0),
    5000: Color.fromRGBO(255, 228, 206, 1.0),
    5100: Color.fromRGBO(255, 230, 210, 1.0),
    5200: Color.fromRGBO(255, 232, 213, 1.0),
    5300: Color.fromRGBO(255, 233, 217, 1.0),
    5400: Color.fromRGBO(255, 235, 220, 1.0),
    5500: Color.fromRGBO(255, 236, 224, 1.0),
    5600: Color.fromRGBO(255, 238, 227, 1.0),
    5700: Color.fromRGBO(255, 239, 230, 1.0),
    5800: Color.fromRGBO(255, 240, 233, 1.0),
    5900: Color.fromRGBO(255, 242, 236, 1.0),
    6000: Color.fromRGBO(255, 243, 239, 1.0),
    6100: Color.fromRGBO(255, 244, 242, 1.0),
    6200: Color.fromRGBO(255, 245, 245, 1.0),
    6300: Color.fromRGBO(255, 246, 247, 1.0),
    6400: Color.fromRGBO(255, 248, 251, 1.0),
    6500: Color.fromRGBO(255, 249, 253, 1.0),
    6600: Color.fromRGBO(254, 249, 255, 1.0),
    6700: Color.fromRGBO(252, 247, 255, 1.0),
    6800: Color.fromRGBO(249, 246, 255, 1.0),
    6900: Color.fromRGBO(247, 245, 255, 1.0),
    7000: Color.fromRGBO(245, 243, 255, 1.0),
    7100: Color.fromRGBO(243, 242, 255, 1.0),
    7200: Color.fromRGBO(240, 241, 255, 1.0),
    7300: Color.fromRGBO(239, 240, 255, 1.0),
    7400: Color.fromRGBO(237, 239, 255, 1.0),
    7500: Color.fromRGBO(235, 238, 255, 1.0),
    7600: Color.fromRGBO(233, 237, 255, 1.0),
    7700: Color.fromRGBO(231, 236, 255, 1.0),
    7800: Color.fromRGBO(230, 235, 255, 1.0),
    7900: Color.fromRGBO(228, 234, 255, 1.0),
    8000: Color.fromRGBO(227, 233, 255, 1.0),
    8100: Color.fromRGBO(225, 232, 255, 1.0),
    8200: Color.fromRGBO(224, 231, 255, 1.0),
    8300: Color.fromRGBO(222, 230, 255, 1.0),
    8400: Color.fromRGBO(221, 230, 255, 1.0),
    8500: Color.fromRGBO(220, 229, 255, 1.0),
    8600: Color.fromRGBO(218, 229, 255, 1.0),
    8700: Color.fromRGBO(217, 227, 255, 1.0),
    8800: Color.fromRGBO(216, 227, 255, 1.0),
    8900: Color.fromRGBO(215, 226, 255, 1.0),
    9000: Color.fromRGBO(214, 225, 255, 1.0),
    9100: Color.fromRGBO(212, 225, 255, 1.0),
    9200: Color.fromRGBO(211, 224, 255, 1.0),
    9300: Color.fromRGBO(210, 223, 255, 1.0),
    9400: Color.fromRGBO(209, 223, 255, 1.0),
    9500: Color.fromRGBO(208, 222, 255, 1.0),
    9600: Color.fromRGBO(207, 221, 255, 1.0),
    9700: Color.fromRGBO(207, 221, 255, 1.0),
    9800: Color.fromRGBO(206, 220, 255, 1.0),
    9900: Color.fromRGBO(205, 220, 255, 1.0),
    10000: Color.fromRGBO(207, 218, 255, 1.0),
    10100: Color.fromRGBO(207, 218, 255, 1.0),
    10200: Color.fromRGBO(206, 217, 255, 1.0),
    10300: Color.fromRGBO(205, 217, 255, 1.0),
    10400: Color.fromRGBO(204, 216, 255, 1.0),
    10500: Color.fromRGBO(204, 216, 255, 1.0),
    10600: Color.fromRGBO(203, 215, 255, 1.0),
    10700: Color.fromRGBO(202, 215, 255, 1.0),
    10800: Color.fromRGBO(202, 214, 255, 1.0),
    10900: Color.fromRGBO(201, 214, 255, 1.0),
    11000: Color.fromRGBO(200, 213, 255, 1.0),
    11100: Color.fromRGBO(200, 213, 255, 1.0),
    11200: Color.fromRGBO(199, 212, 255, 1.0),
    11300: Color.fromRGBO(198, 212, 255, 1.0),
    11400: Color.fromRGBO(198, 212, 255, 1.0),
    11500: Color.fromRGBO(197, 211, 255, 1.0),
    11600: Color.fromRGBO(197, 211, 255, 1.0),
    11700: Color.fromRGBO(197, 210, 255, 1.0),
    11800: Color.fromRGBO(196, 210, 255, 1.0),
    11900: Color.fromRGBO(195, 210, 255, 1.0),
    12000: Color.fromRGBO(195, 209, 255, 1.0),
  };
}
