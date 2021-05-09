import 'dart:io';
import 'dart:ui';

class ArduinoSocketService {
  Socket socket;

  Future<void> sendColor(Color color) async {
    await initConnection();
    String command = color.red.toString() +
        " " +
        color.green.toString() +
        " " +
        color.blue.toString() + "\n";
    socket.write(command);
    // endConnection();
  }

  Future<void> initConnection() async {
    if (socket == null) {
      socket = await Socket.connect("192.168.0.182", 2000);
    }
  }


  void endConnection() {
    if (socket != null) {
      socket.destroy();
      socket = null;
    }
  }
}
