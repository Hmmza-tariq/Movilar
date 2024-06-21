import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movilar/app/modules/mqtt/controllers/mqtt_manager.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttController extends GetxController {
  var isConnected = false.obs;
  var message = ''.obs;

  final MQTTAppState currentState = Get.put(MQTTAppState());
  MqttServerClient? client;
  var identifier = "1234".obs;
  var host = "test.mosquitto.org".obs;

  TextEditingController messageController = TextEditingController();
  TextEditingController topicController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initializeMQTTClient();
  }

  void initializeMQTTClient() {
    client = MqttServerClient(host.value, identifier.value);
    client!.port = 1883;
    client!.keepAlivePeriod = 20;
    client!.onDisconnected = onDisconnected;
    client!.secure = false;
    client!.logging(on: true);

    /// Add the successful connection callback
    client!.onConnected = onConnected;
    client!.onSubscribed = onSubscribed;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(identifier.value)
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    client!.connectionMessage = connMess;
  }

  void connect() async {
    assert(client != null);
    try {
      print('EXAMPLE::Mosquitto start client connecting....');
      currentState.setAppConnectionState(MQTTAppConnectionState.connecting);
      await client!.connect();
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      disconnect();
    }
  }

  void disconnect() {
    print('Disconnected');
    client!.disconnect();
    currentState.setAppConnectionState(MQTTAppConnectionState.disconnected);
  }

  void publish() {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(messageController.text);
    client!.publishMessage(
        topicController.text, MqttQos.exactlyOnce, builder.payload!);
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (client!.connectionStatus!.returnCode ==
        MqttConnectReturnCode.noneSpecified) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
    currentState.setAppConnectionState(MQTTAppConnectionState.disconnected);
  }

  /// The successful connect callback
  void onConnected() {
    currentState.setAppConnectionState(MQTTAppConnectionState.connected);
    print('EXAMPLE::Mosquitto client connected....');
  }

  void subscribe() {
    client!.subscribe(topicController.text, MqttQos.atLeastOnce);
    client!.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      currentState.setReceivedText(pt);
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });
    print(
        'EXAMPLE::OnConnected client callback - Client connection was successful');
  }
  // Future<void> connect() async {
  //   client = MqttServerClient('test.mosquitto.org', 'New_User_1024');
  //   await client.connect('flutter_client');
  // }

  // Future<void> subscribe(String topic) async {
  //   client.subscribe(topic, MqttQos.atLeastOnce);
  // }

  // void publishMessage(String topic, String message) {
  //   final builder = MqttClientPayloadBuilder();
  //   builder.addString(message);
  //   client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  // }
  // @override
  // void onInit() {
  //   super.onInit();
  //   initializeMqttClient();
  // }

  // void initializeMqttClient() {
  //   client = MqttServerClient.withPort('broker.hivemq.com', '#', 1883);
  //   client.logging(on: true);
  //   client.onDisconnected = onDisconnected;
  //   client.onConnected = onConnected;
  //   client.onSubscribed = onSubscribed;

  //   final connMessage = MqttConnectMessage()
  //       .withClientIdentifier('clientIdentifier')
  //       .withWillTopic(
  //           'willtopic') // If you set this you must set a will message
  //       .withWillMessage('My Will message')
  //       .startClean() // Non persistent session for testing
  //       .withWillQos(MqttQos.atLeastOnce);
  //   client.connectionMessage = connMessage;
  // }

  // void onSubscribed(String topic) {
  //   print('Subscribed to topic: $topic');
  // }

  // void onDisconnected() {
  //   print('Disconnected');
  // }

  // void onConnected() {
  //   print('Connected');
  // }

  // Future<MqttServerClient> connect() async {
  //   client.logging(on: true);
  //   client.keepAlivePeriod = 20;
  //   client.onDisconnected = onDisconnected;
  //   client.onConnected = onConnected;
  //   client.onSubscribed = onSubscribed;

  //   final connMessage = MqttConnectMessage()
  //       .withClientIdentifier('flutter_client')
  //       .withWillTopic('willtopic')
  //       .withWillMessage('My Will message')
  //       .startClean()
  //       .withWillQos(MqttQos.atLeastOnce);
  //   client.connectionMessage = connMessage;

  //   try {
  //     await client.connect();
  //   } catch (e) {
  //     print('Exception: $e');
  //     client.disconnect();
  //   }

  //   if (client.connectionStatus?.state == MqttConnectionState.connected) {
  //     print('Client connected');
  //   } else {
  //     print(
  //         'ERROR: Client connection failed - disconnecting, state is ${client.connectionStatus?.state}');
  //     client.disconnect();
  //   }

  //   return client;
  // }

  // Future<void> subscribe(String topic) async {
  //   if (client.connectionStatus!.state == MqttConnectionState.connected) {
  //     client.subscribe(topic, MqttQos.atLeastOnce);
  //     client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) async {
  //       final recMess = c[0].payload as MqttPublishMessage;
  //       final pt =
  //           MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
  //       print('Received message: $pt from topic: ${c[0].topic}>');
  //       message.value = pt;
  //     });
  //   }
  // }

  // void publishMessage(String topic, String message) {
  //   if (client.connectionStatus?.state == MqttConnectionState.connected) {
  //     final builder = MqttClientPayloadBuilder();
  //     builder.addString(message);
  //     client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  //   } else {
  //     print('ERROR: MQTT client is not connected.');
  //     Get.snackbar("Error", "MQTT client is not connected",
  //         colorText: ColorManager.white, backgroundColor: ColorManager.red);
  //   }
  // }

  @override
  void onClose() {
    disconnect();
    super.onClose();
  }
}
