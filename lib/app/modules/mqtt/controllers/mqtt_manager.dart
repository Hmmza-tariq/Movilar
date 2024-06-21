import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

enum MQTTAppConnectionState { connected, disconnected, connecting }

class MQTTAppState extends GetxController {
  var appConnectionState = MQTTAppConnectionState.disconnected.obs;
  var receivedText = ''.obs;
  var historyText = ''.obs;

  void setReceivedText(String text) {
    receivedText.value = text;
    historyText.value = '${historyText.value}\n${receivedText.value}';
  }

  void setAppConnectionState(MQTTAppConnectionState state) {
    appConnectionState.value = state;
  }
}

class MQTTManager extends GetxController {
  // Private instance of client
  final MQTTAppState currentState = Get.put(MQTTAppState());
  MqttServerClient? client;
  final String identifier;
  final String host;
  final String topic;

  // Constructor
  MQTTManager({
    required this.host,
    required this.topic,
    required this.identifier,
  });

  void initializeMQTTClient() {
    client = MqttServerClient(host, identifier);
    client!.port = 1883;
    client!.keepAlivePeriod = 20;
    client!.onDisconnected = onDisconnected;
    client!.secure = false;
    client!.logging(on: true);

    /// Add the successful connection callback
    client!.onConnected = onConnected;
    client!.onSubscribed = onSubscribed;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(identifier)
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    client!.connectionMessage = connMess;
  }

  // Connect to the host
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

  void publish(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client!.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
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
    client!.subscribe(topic, MqttQos.atLeastOnce);
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
}
