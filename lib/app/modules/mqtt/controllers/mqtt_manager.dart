import 'package:get/get.dart';

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
