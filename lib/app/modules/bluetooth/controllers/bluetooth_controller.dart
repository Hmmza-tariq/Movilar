import 'dart:io';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  var isConnected = false.obs;
  var connectedDevices = <BluetoothDevice>[].obs;

  @override
  void onInit() {
    super.onInit();
    checkBluetoothState();
  }

  void checkBluetoothState() async {
    isConnected.value =
        await FlutterBluePlus.adapterState.first == BluetoothAdapterState.on;
    FlutterBluePlus.adapterState.listen((state) async {
      isConnected.value = state == BluetoothAdapterState.on;
    });
  }

  Future<List<BluetoothDevice>> getConnectedDevices() {
    var devices = FlutterBluePlus.bondedDevices.then((value) {
      connectedDevices.addAll(value);
      return value;
    });

    return devices;
  }

  void turnON() async {
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }
  }

  void turnOFF() async {
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOff();
    }
  }
}
