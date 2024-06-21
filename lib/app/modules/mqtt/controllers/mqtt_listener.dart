import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movilar/app/modules/home/controllers/home_controller.dart';
import 'package:movilar/app/modules/widgets/loading.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTListener extends GetxController {
  MqttServerClient? client;
  var identifier = "listener".toString();
  var host = "test.mosquitto.org".obs;

  @override
  void onInit() {
    super.onInit();
    initializeMQTTClient();
    listenRefresh();
  }

  @override
  void onClose() {
    disconnect();
    super.onClose();
  }

  void initializeMQTTClient() {
    client = MqttServerClient(host.value, identifier);
    client!.port = 1883;
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
    debugPrint('Subscribed listener $topic');
  }

  void onDisconnected() {
    debugPrint('Disconnected listener');
  }

  void onConnected() {
    debugPrint('Connected listener');
  }

  void disconnect() {
    client!.disconnect();
  }

  void listenRefresh() async {
    assert(client != null);
    try {
      await client!.connect();
      client!.subscribe("cowlar/movie-task", MqttQos.atLeastOnce);
    } on Exception catch (e) {
      debugPrint('Exception: $e');
      disconnect();
    }
    client!.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) async {
      final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      if (pt == "refresh_movies") {
        HomeController homeController = Get.find();
        await homeController.fetchMovies();
        closeLoading();
      }
    });
  }
}
