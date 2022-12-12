import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:smart_light/entity/LightState.dart';

import '../../entity/Device.dart';
import '../../entity/User.dart';
import '../shared_preferences_service.dart';

class MQTTService {
  MqttServerClient _client;
  bool _isConnected = false;
  String response_topic = "";
  String request_topic = "";
  SharedPreferencesService _sharedPreferencesService;

  MQTTService._() {
    _sharedPreferencesService = SharedPreferencesService.getInstance();
  }

  static final instance = MQTTService._();

  Future<MqttServerClient> connect() async {
    Device device =
        Device.fromJson(_sharedPreferencesService.getObject("active_device"));
    if (device == null || device.id == null) {
      Fluttertoast.showToast(
          msg: "Не обрано пристрій",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    } else {
      response_topic = device.id + "/response";
      request_topic = device.id + "/control";
    }

    Fluttertoast.showToast(
        msg: "З'єднання!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.orangeAccent,
        textColor: Colors.white,
        fontSize: 16.0);

    _client =
        MqttServerClient.withPort('192.168.0.191', 'flutter_client', 1883);

    _client.logging(on: true);
    _client.onConnected = onConnected;
    _client.onDisconnected = onDisconnected;
    _client.onUnsubscribed = onUnsubscribed;
    _client.onSubscribed = onSubscribed;
    _client.onSubscribeFail = onSubscribeFail;
    _client.pongCallback = pong;
    // _client.autoReconnect = true;

    final connMessage = MqttConnectMessage()
        .authenticateAs('emqx', 'public')
        .keepAliveFor(60)
        .withWillTopic(request_topic)
        .withWillMessage("health")
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    _client.connectionMessage = connMessage;
    try {
      await _client.connect();
    } catch (e) {
      print('Exception: $e');
      _client.disconnect();
    }

    _client.subscribe(response_topic, MqttQos.exactlyOnce);

    _client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);
      if (_isConnected && payload == "Alive!") {
        Fluttertoast.showToast(
            msg: "Під'єднано!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        print('Connected');
      }
      print('Received message:\n$payload from topic: ${c[0].topic}>');
      LightState.getInstance().updateFromString(payload);
    });
    return _client;
  }

  void onConnected() {
    _isConnected = true;
    User user = User.fromJson(_sharedPreferencesService.getObject("user"));
    publishMessage(request_topic,
        "user ${user.id} ${user.age} ${user.gender == "MALE" ? 1 : 0}");
    // Fluttertoast.showToast(
    //     msg: "Під'єднано!",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.green,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
    // print('Connected');
  }

// unconnected
  void onDisconnected() {
    _isConnected = false;
    Fluttertoast.showToast(
        msg: "Від'єднано",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    print('Disconnected');
  }

// subscribe to topic succeeded
  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
    // Fluttertoast.showToast(
    //     msg: "Під'єднано!",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.green,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
    print('Connected');
  }

// subscribe to topic failed
  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

// unsubscribe succeeded
  void onUnsubscribed(String topic) {
    print('Unsubscribed topic: $topic');
  }

// PING response received
  void pong() {
    print('Ping response client callback invoked');
  }

  int publishMessage(String topic, String message) {
    final data = MqttClientPayloadBuilder();
    data.addString(message);

    if (_client == null ||
        !_isConnected ||
        _client.connectionStatus.state == MqttConnectionState.disconnected ||
        _client.connectionStatus.state == MqttConnectionState.disconnecting) {
      connect();
      _isConnected = true;
      return 0;
    } else if (_client.connectionStatus.state ==
        MqttConnectionState.connecting) {
      Fluttertoast.showToast(
          msg: "З'єднання!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orangeAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      return _client.publishMessage(topic, MqttQos.exactlyOnce, data.payload);
    }
  }

  MqttServerClient get client {
    if (_client == null || !_isConnected) {
      connect();
    }
    return _client;
  }

  bool get isConnected => _isConnected;
}
