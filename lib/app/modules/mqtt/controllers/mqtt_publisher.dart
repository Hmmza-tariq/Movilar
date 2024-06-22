import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:movilar/app/modules/widgets/loading.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTPublisher extends GetxController {
  MqttServerClient? client;
  var identifier = "publisher".toString();
  final String host = dotenv.env['HOST'] ?? '';
  final int port = int.parse(dotenv.env['PORT'].toString());

  @override
  void onInit() {
    super.onInit();
    initializeMQTTClient();
  }

  @override
  void onClose() {
    disconnect();
    super.onClose();
  }

  void initializeMQTTClient() {
    client = MqttServerClient(host, identifier);
    client!.port = port;
    client!.keepAlivePeriod = 20;
    client!.onDisconnected = onDisconnected;
    client!.secure = false;
    client!.logging(on: false);

    client!.onConnected = onConnected;
    client!.onSubscribed = onSubscribed;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(identifier)
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    client!.connectionMessage = connMess;
  }

  void onSubscribed(String topic) {
    debugPrint('Subscribed publisher $topic');
  }

  void onDisconnected() {
    debugPrint('Disconnected publisher');
  }

  void onConnected() {
    debugPrint('Connected publisher');
  }

  void disconnect() {
    client!.disconnect();
  }

  void refreshPressed() async {
    showLoadingWidget("Refreshing Movies");
    try {
      await client!.connect();
      client!.subscribe("cowlar/movie-task", MqttQos.atLeastOnce);
      final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
      builder.addString("refresh_movies");
      client!.publishMessage(
          "cowlar/movie-task", MqttQos.exactlyOnce, builder.payload!);
    } catch (e) {
      closeLoading();
      Get.snackbar("Error", e.toString());
    }
  }
}
