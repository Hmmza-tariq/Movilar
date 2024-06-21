import 'package:get/get.dart';

import '../controllers/mqtt_controller.dart';

class MqttBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MqttController>(
      () => MqttController(),
    );
  }
}
