import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:movilar/app/modules/mqtt/controllers/mqtt_manager.dart';
import 'package:movilar/app/modules/widgets/loading.dart';
import 'package:movilar/app/services/internet_service.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'dart:math';

class MqttController extends GetxController {
  var isConnected = false.obs;
  var isSubscribed = false.obs;
  var message = <String>[].obs;
  final String host = dotenv.env['HOST'] ?? '';
  final int port = int.parse(dotenv.env['PORT'].toString());

  final MQTTAppState currentState = Get.put(MQTTAppState());
  MqttServerClient? client;
  var identifier = String.fromCharCodes(
      List.generate(5, (index) => Random().nextInt(33) + 89));

  TextEditingController messageController = TextEditingController();
  TextEditingController topicController =
      TextEditingController(text: "cowlar/movie-task");

  final InternetService internetService = Get.find<InternetService>();

  @override
  void onInit() {
    super.onInit();
    internetService.checkInternet();
    internetService.listenInternet();
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

  Future<void> connect() async {
    assert(client != null);
    try {
      currentState.setAppConnectionState(MQTTAppConnectionState.connecting);
      await client!.connect();
    } on Exception catch (e) {
      debugPrint('Exception: $e');
      disconnect();
    }
    closeLoading();
  }

  Future<void> subscribe() async {
    if (isConnected.value == false) {
      Get.snackbar("Error", "Please connect to server first",
          duration: const Duration(seconds: 2),
          colorText: Colors.white,
          backgroundColor: Colors.red);
      Future.delayed(const Duration(seconds: 2), () {
        Get.closeAllSnackbars();
      });
      return;
    }

    showLoadingWidget("Subscribing to Topic");

    client!.subscribe(topicController.text, MqttQos.atLeastOnce);
    isSubscribed.value = true;
    closeLoading();
    client!.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      currentState.setReceivedText(pt);
      message.add("$pt,${c[0].topic}");
    });
  }

  Future<void> publish() async {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(messageController.text);
    client!.publishMessage(
        topicController.text, MqttQos.exactlyOnce, builder.payload!);
  }

  void onSubscribed(String topic) {
    debugPrint('Subscribed client $topic');
    isSubscribed.value = true;
  }

  void onDisconnected() {
    debugPrint('Disconnected client');

    isSubscribed.value = false;
    isConnected.value = false;
    if (client!.connectionStatus!.returnCode ==
        MqttConnectReturnCode.noneSpecified) {}
    currentState.setAppConnectionState(MQTTAppConnectionState.disconnected);
  }

  void onConnected() {
    debugPrint('Connected client');
    currentState.setAppConnectionState(MQTTAppConnectionState.connected);
    isConnected.value = true;
  }

  void disconnect() {
    isConnected.value = false;
    client!.disconnect();
    currentState.setAppConnectionState(MQTTAppConnectionState.disconnected);
  }
}
