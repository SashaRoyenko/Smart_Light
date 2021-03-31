import 'dart:ui';

class UtilService {
  static Color getColorFromHex(String color) {
    String colorHex = color.replaceAll("Color(", "");
    colorHex = colorHex.replaceAll(")", "");
    return Color(int.parse(colorHex));
  }

  static void addTimeDateTime(DateTime value, DateTime timeToAdd) {

  }

}